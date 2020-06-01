//
//  CircularTimer.swift
//  bicalms
//
//  Created by Eko Cahyo on 31/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI

struct CircularTimer30: View {
    
    var baseColor:Color
    var progress:CGFloat
    
    @Binding var show: Bool
    @Binding var running: Bool
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .trim(from: progress, to: 0)
                .stroke(Color("Orange2"), lineWidth: 5)
                .rotationEffect(.degrees(90))
                .frame(width: 360, height: 360)
        }
    }
}
