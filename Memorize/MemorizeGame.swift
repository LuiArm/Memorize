//
//  MemorizeGame.swift
//  Memorize
//
//  Created by luis armendariz on 1/27/24.
//

import Foundation



//struct MemoryGame<CardContent> where CardContent: Equatable {
//    private(set) var cards: Array<Card>
//
//    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
//    get {
//        var faceUpCardIndices = [Int]()
//        for index in cards.indices {
//            if cards[index].isFaceUp {
//                faceUpCardIndices.append(index)
//            }
//
//        }
//        set {
//            for index in cards.indices {
//                if index != newValue{
//                    cards[index].isFaceUp = false
//                } else {
//                    cards[index].isFaceUp = true
//                }
//
//            }
//        }
//    }
//
//    mutating func choose(card: Card) {
//        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
//           !cards[chosenIndex].isFaceUp,
//           !cards[chosenIndex].isMatched
//        {
//            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
//                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
//                    cards[chosenIndex].isMatched = true
//                    cards[potentialMatchIndex].isMatched = true
//                }
//                cards[chosenIndex].isFaceUp = true
//            } else {
//
//                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
//            }
//
//        }
//        print("\(cards)")
//    }
//
//    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
//        cards = []
//        // add numberOfPairOfCards X 2 cards to cards array
//        for pairIndex in 0...numberOfPairOfCards{
//            let content = createCardContent(pairIndex)
//            cards.append(Card(content: content,id: pairIndex*2))
//            cards.append(Card(content: content,id: pairIndex*2+1))
//
//        }
//    }
//
//    struct Card: Identifiable {
//        var isFaceUp = false
//        var isMatched = false
//        let content: CardContent
//        let id: Int
//    }
//}
//
//



struct MemorizeGame<CardContent> where CardContent: Equatable {
    private (set) var cards: Array<Card>
    private (set) var score = 0
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards X 2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { index in cards[index].isFaceUp }.only }
        set {
            return cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
//            for index in cards.indices {
//                if index == newValue {
//                    cards[index].isFaceUp = true
//                } else {
//                    cards[index].isFaceUp = false
//                }
//            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            //game logic
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2 + cards[chosenIndex].bonus
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        var id = UUID()
        var hasBeenSeen = false
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                }else {
                    stopUsingBonusTime()
                }
                if oldValue && !isFaceUp {
                    hasBeenSeen = true 
                }
            }
        }
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        
        let content: CardContent
        
        // MARK: - Bonus time
        
        //this could give matching bonus points
        //if the user matches the card
        //before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        //how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        //the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
            //the accumlated time this card has been face up in the past
            // i.e. not including the current time its been face up if it is currently so
        var pastFaceUpTime: TimeInterval = 0
        
        //how much time left before the bonus oppotunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        //percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        // whether the card matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        //whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        //called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
