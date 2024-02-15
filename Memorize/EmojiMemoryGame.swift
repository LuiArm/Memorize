//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by luis armendariz on 4/17/23.
//

import SwiftUI



//class EmojiMemoryGame: ObservableObject {
//    typealias Card = MemoryGame<String>.Card
//    
//    private static let emojis = ["🛻","🚓","🚝", "🚖","🛴","🚛","🏎️","🚲","🛵","🏍️","🛺","🚔","🚘","🚠","🚀","🛶","⛵️","🚢","🛳️","🚊","✈️"]
//    
//    private static func createMemoryGame() -> MemoryGame<String> {
//        MemoryGame<String>(numberOfPairOfCards: 4) { pairIndex in
//            emojis[pairIndex]
//        }
//    }
//    
//
//    
//    @Published private var model = createMemoryGame()
// 
//    
//    var cards: Array<Card> {
//        return model.cards
//        
//    }
//    
//        // MARK: - Intent(s)
//    func choose(_ card: Card) {
//        model.choose(card: card)
//    }
//    
//}


class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🛻","🚓","🚝", "🚖","🛴","🚛","🏎️","🚲","🛵","🏍️","🛺","🚔","🚘","🚠","🚀","🛶","⛵️","🚢","🛳️","🚊","✈️"]
        
    
    private static func createMemoryGame()  -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: 10 ) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "😬"
            }
        }
    }
    
    @Published private var model = createMemoryGame()

    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    
    func choose(_ card: MemorizeGame<String>.Card){
        model.choose(card)
    }
}
