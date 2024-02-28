//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by luis armendariz on 4/6/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemorizeGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack{
            cards
                .foregroundStyle(viewModel.color)
            HStack {
                score
                Spacer()
                shuffle
            }
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle"){
            withAnimation{
                viewModel.shuffle()
            }
        }
    }
    
//    var transportCards = ["🚌","🚌","🚲","🚲","🛻","🛻","🛺","🛺"]
//    var transportButton: some View {
//        Button{
//            emojis = transportCards.shuffled()
//        }label: {
//            Text("Vehicles")
//        }
//    }
//    
//    var foodCards = ["🍔","🍔","🥐","🥐","🍕","🍕","🥩","🥩"]
//    var foodButton: some View {
//        Button{
//            emojis = foodCards.shuffled()
//        }label: {
//            Text("Food")
//        }
//    }
//    
//    var flagCards = ["🇲🇽","🇲🇽","🇵🇸","🇵🇸","🇦🇷","🇦🇷","🇧🇷","🇧🇷"]
//    var flagButton: some View {
//        Button{
//            emojis = flagCards.shuffled()
//        }label: {
//            Text("Flags")
//        }
//    }
    
//    func cardCountAdjusters(by offset: Int, symbol: String) -> some View {
//        Button{
//                cardCount += offset
//        }label: {
//            Image(systemName: symbol)
//        }
//        .disabled(cardCount + offset < 1 || cardCount  + offset > transportCards.count)
//    }
    
//    //Computed property for lightweight view
//    var CardAdder: some View {
//        cardCountAdjusters(by: 1, symbol: "plus.circle")
//    }
//    
//    //Computed property for lightweight view
//    var CardRemover: some View {
//        cardCountAdjusters(by: -1, symbol: "minus.circle")
//    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .padding(4)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .transition(.offset(
                        x: CGFloat.random(in: -1000...1000),
                        y: CGFloat.random(in: -1000...1000)
                    ))
            }
        }
        .onAppear {
        //deal the cards
            withAnimation(.easeInOut(duration: 2)){
                for card in viewModel.cards {
                    dealt.insert(card.id)
                }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    private func choose(_ card: Card) {
        withAnimation{
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: UUID())
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
            
    }
}
