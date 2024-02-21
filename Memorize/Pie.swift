//
//  Pie.swift
//  Memorize
//
//  Created by luis armendariz on 2/19/24.
//

import SwiftUI


struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var p = Path()
    }
    
    
}
