//
//  MemorizeApp.swift
//  Memorize
//
//  Created by luis armendariz on 4/6/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
