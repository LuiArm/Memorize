//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by luis armendariz on 4/6/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  
    
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .foregroundStyle(.orange)
        .padding()
    }
}

//Card view to make it reusable
struct CardView: View {
    //gives cardview a default value for isFaceUp otherwise need to provide when creating new cardview
   @State var isFaceUp = false
    
    var body: some View {
        let shape = RoundedRectangle(cornerSize: CGSize(width: 70, height:70))
        ZStack{
            if isFaceUp {
                shape
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(.white)
                shape
                    .strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            }else {
                //.fill is default for shape
                shape
            }
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
