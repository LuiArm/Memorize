//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by luis armendariz on 4/6/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame 
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack{
                cards
                .foregroundStyle(viewModel.color)
                    .animation(.default, value: viewModel.cards)
            Spacer()
            Button("Shuffle"){
                viewModel.shuffle()
            }
         }
        .padding()
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
                    CardView(card)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
        
    }
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
            
    }
}
