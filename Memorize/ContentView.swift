//
//  ContentView.swift
//  Memorize
//
//  Created by luis armendariz on 4/6/23.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🛻","🚓","🚝", "🚖"]
    var body: some View {
        HStack{
            ForEach(emojis, id: \.self, content: {emoji in
                CardView(content: emoji)
            })
        }
        .padding(.horizontal)
        .foregroundColor(.red)
        
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            }  else {
                shape.fill().foregroundColor(.blue)
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
