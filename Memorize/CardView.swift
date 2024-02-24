//
//  CardView.swift
//  Memorize
//
//  Created by luis armendariz on 2/16/24.
//

import SwiftUI

//Card view to make it reusable
struct CardView: View {
    typealias Card = MemorizeGame<String>.Card
    
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    
    
    var body: some View {
        Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 50))
            .opacity(0.5)
            .overlay(
                Text(card.content)
                    .font(.system(size: 120))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0 ))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
            )
            .padding(5)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(!card.isMatched || card.isFaceUp ? 1 : 0)
    }
    
}



//#Preview {
//    typealias Card = CardView.Card
//    CardView(Card(id: UUID(), content: "X"))
//        .padding()
//        .foregroundStyle(.green)
//}
