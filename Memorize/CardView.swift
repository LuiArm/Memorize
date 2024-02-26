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
        TimelineView(AnimationTimelineSchedule(minimumInterval: 1/5)) { timeline in
            Pie(endAngle: Angle(degrees: card.bonusPercentRemaining * 360))
                .opacity(0.5)
                .overlay(cardContents .padding(5))
                .padding(5)
                .cardify(isFaceUp: card.isFaceUp)
                .opacity(!card.isMatched || card.isFaceUp ? 1 : 0)
        }
        
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: 120))
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
           
            .rotationEffect(.degrees(card.isMatched ? 360 : 0 ))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
    }
    
}



//#Preview {
//    typealias Card = CardView.Card
//    CardView(Card(id: UUID(), content: "X"))
//        .padding()
//        .foregroundStyle(.green)
//}
