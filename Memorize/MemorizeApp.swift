//
//  MemorizeApp.swift
//  Memorize
//
//  Created by luis armendariz on 4/6/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
