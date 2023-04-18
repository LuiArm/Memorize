//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by luis armendariz on 4/17/23.
//

import SwiftUI



class EmojiMemoryGame {
    static let emojis = ["🛻","🚓","🚝", "🚖","🛴","🚛","🏎️","🚲","🛵","🏍️","🛺","🚔","🚘","🚠","🚀","🛶","⛵️","🚢","🛳️","🚊","✈️"]
    
    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairOfCards: 4, createCardContent: { pairIndex in
        return emojis[pairIndex]
    })
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
        
    }
}
