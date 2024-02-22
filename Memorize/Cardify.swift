//
//  Cardify.swift
//  Memorize
//
//  Created by luis armendariz on 2/21/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerSize: CGSize(width: 15, height:15))
            shape.fill(.white)
            shape.strokeBorder(lineWidth: 2)
                .background(shape.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            //.fill is default for shape
            shape.opacity(isFaceUp ? 0 : 1)
        }
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
