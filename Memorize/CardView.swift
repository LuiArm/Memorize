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
            if !card.isMatched || card.isFaceUp {
                Pie(endAngle: Angle(degrees: card.bonusPercentRemaining * 360))
                    .opacity(0.5)
                    .overlay(cardContents .padding(5))
                    .padding(5)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
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
