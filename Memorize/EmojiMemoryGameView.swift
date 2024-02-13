//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by luis armendariz on 4/6/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame 
    
    var body: some View {
        VStack{
            Text("MEMORIZE").font(.largeTitle)
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            .navigationTitle("MEMORIZE!")
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
    
    var cards: some View {
        let aspectRatio: CGFloat = 2/3
        
        return GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: viewModel.cards.count, size: geometry.size, atAspectRatio: 2/3)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundStyle(.orange)
    }

    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        return 95
    }
}




//Card view to make it reusable
struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        let shape = RoundedRectangle(cornerSize: CGSize(width: 30, height:30))
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
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
            
    }
}
