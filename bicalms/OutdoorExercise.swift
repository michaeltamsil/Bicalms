//
//  Outdoor Exercise.swift
//  bicalms
//
//  Created by Eko Cahyo on 26/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct OutdoorExrecise : View {
    
    @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State private var countUp = -1
    @State private var show = true
    @State private var running = true
    
    var body: some View {

        ZStack{
            
            LinearGradient(gradient: .init(colors: [(Color("Blue2")), (Color("Blue1"))]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            ZStack{
                
                LinearGradient(gradient: .init(colors: [(Color("Orange3")), (Color("Orange1"))]), startPoint: .top, endPoint: .bottom)
                    
                    .mask(
                        Circle()
                            .stroke(lineWidth: 5)
                            .padding()
                            .frame(width: 360, height: 360)
                    )
                
                OutdoorAnimation().frame(width: 360, height: 360, alignment: .center)
                    .clipShape(Circle())
            }
            
            VStack(spacing: 88){
                
                HStack{
                    
                    Spacer()
                    Image(systemName: "xmark")
                        .frame(width: 64)
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 480){
                    
                    VStack(spacing: 4){
                        
                        Text("Outdoor Exercise")
                            .font(.body)
                            .foregroundColor(Color("White50"))
                        
                        Text("Running")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                    HStack{

                        if (running) {
                            Image(systemName: "arrow.counterclockwise")
                            .frame(width: 96)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            
                            Button(action: {
                                self.play()
                            }) {
                                Image(systemName: "play.fill")
                                    .frame(width: 96)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)   
                            }
                            
                            Image(systemName: "info.circle")
                                    .frame(width: 96)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)

                        } else {
                            Text("\(countUp)")
                            .frame(width: 96)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .onTapGesture() {
                                self.pause()
                            }
                            
                        }
                    }
                     .onReceive(timer) { (output) in
                        if self.countUp < -1 {
                            // We don't need it when we start off
                            self.timer.upstream.connect().cancel()
                        }
                        if self.countUp > -1 {
                            self.countUp += 1
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    func play() {
        self.running = false
        if (show) {
            self.countUp += 1
            self.show = false
        }
        
        self.timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    }
    
    func pause() {
        self.timer.upstream.connect().cancel()
        self.running = true
    }
}

struct OutdoorExercise_Previews: PreviewProvider {
    static var previews: some View {
        OutdoorExrecise()
    }
}
