//
//  MemoryGame.swift
//  Memorize
//
//  Created by luis armendariz on 4/17/23.
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
//    extension Array {
//        var oneAndOnly: Element? {
//            if self.count == 1 {
//                return self.first
//            } else {
//                return nil
//            }
//        }
//    }
