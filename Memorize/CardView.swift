//
//  CardView.swift
//  Memorize
//
//  Created by luis armendariz on 2/16/24.
//

import SwiftUI

//Card view to make it reusable
struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        let shape = RoundedRectangle(cornerSize: CGSize(width: 15, height:15))
        ZStack{
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 120))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
                //.fill is default for shape
            shape.opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(!card.isMatched || card.isFaceUp ? 1 : 0)
    }
}

#Preview {
    CardView()
}
