//
//  TicksView.swift
//  bicalms
//
//  Created by Eko Cahyo on 31/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI

struct Tick: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + 10))
        return path
    }
}

struct TicksView30: View {
    var body: some View {
        ZStack{
            ForEach(0..<30) { position in
                Tick()
                    .stroke(lineWidth: 5)
                    .rotationEffect(.radians(Double.pi*2 / 30*Double(position)))
            }
        }
    }
}

struct TicksView30_Previews: PreviewProvider {
    static var previews: some View {
        TicksView30()
    }
}
