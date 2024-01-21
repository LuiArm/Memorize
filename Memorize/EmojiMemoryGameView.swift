//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by luis armendariz on 4/6/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
     
    let emojis = ["👻", "🌮", "🍩","🍜","🍜","👻", "🌮", "🍩","🍜","🍜","👻", "🌮", "🍩","🍜","🍜"]
    
    @State var cardCount: Int = 5
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardAdjusters
        }
        .padding()
    }
    
    func cardCountAdjusters(by offset: Int, symbol: String) -> some View {
        Button{
                cardCount += offset
        }label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount  + offset > emojis.count)
    }
    
    //Computed property for lightweight view
    var CardAdder: some View {
        cardCountAdjusters(by: 1, symbol: "plus.circle")
    }
    
    //Computed property for lightweight view
    var CardRemover: some View {
        cardCountAdjusters(by: -1, symbol: "minus.circle")
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { emoji in
                CardView(content: emojis[emoji])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    var cardAdjusters: some View {
        HStack{
           CardRemover
            Spacer()
          CardAdder
        }
        .font(.largeTitle)
    }
}




//Card view to make it reusable
struct CardView: View {
    //gives cardview a default value for isFaceUp otherwise need to provide when creating new cardview
   @State var isFaceUp = false
    var content: String
    var body: some View {
        let shape = RoundedRectangle(cornerSize: CGSize(width: 30, height:30))
        ZStack{
            Group {
                shape
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(.white)
                shape
                    .strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
                //.fill is default for shape
            shape.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            print("Tapped")
            //isFaceUp is a struct so you can call toggle function on it
            isFaceUp.toggle()
        }
    }
}
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      
        EmojiMemoryGameView()
            
    }
}
