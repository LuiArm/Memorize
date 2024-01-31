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


class EmojiMemoryGame {
    private var model = MemorizeGame(numberOfPairsOfCards: 4) { pairIndex in
        return  ["🛻","🚓","🚝", "🚖","🛴","🚛","🏎️","🚲","🛵","🏍️","🛺","🚔","🚘","🚠","🚀","🛶","⛵️","🚢","🛳️","🚊","✈️"][pairIndex]
        
    }
    
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemorizeGame<String>.Card){
        model.chooseCards(card: card)
    }
}
