//
//  IndoorExercise.swift
//  bicalms
//
//  Created by Eko Cahyo on 26/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct IndoorExercise : View {
    
    @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State private var countDown = 31
    @State private var show = true
    @State private var running = true
    @State private var isPlaying = false
    
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
                
                IndoorAnimation()
                    .frame(width: 360, height: 360, alignment: .center)
                    .clipShape(Circle())
            }
            
            VStack(spacing: 64){
                
                HStack{
                    
                    Spacer()
                    Image(systemName: "xmark")
                        .frame(width: 64)
                        .padding(.top,40)
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 460){
                    
                    VStack(spacing: 4){
                        
                        Text("01/10")
                            .font(.body)
                            .foregroundColor(Color("White50"))
                        
                        Text("Exercise Name")
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
                                VStack {
                                    Text("\(countDown)")
                                        .frame(width: 96, height: 48)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .background(Color("White10"))
                                        .cornerRadius(24)
                                        .padding(.bottom, 16)
                                        .padding(.top, 16)
                                        .onTapGesture() {
                                            self.pause()
                                    }
                                    
                                    HStack {
                                        Image(systemName: "arrow.counterclockwise")
                                            .frame(width: 96)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        
                                        Button(action: {
                                            self.playOrPause()
                                        }) {
                                            if (isPlaying) {
                                                Image(systemName: "pause.fill")
                                                .frame(width: 96)
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                            } else {
                                                Image(systemName: "play.fill")
                                                .frame(width: 96)
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                            }
                                            
                                        }
                                        
                                        Image(systemName: "info.circle")
                                            .frame(width: 96)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                            
                     .onReceive(timer) { (output) in
                        if self.countDown > 31 {
                            // We don't need it when we start off
                            self.timer.upstream.connect().cancel()
                        }
                        if self.countDown < 31 {
                            self.countDown -= 1
                        }
                        
                        if self.countDown == 0 {
                            
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    func play() {
        self.running = false
        self.isPlaying = true
        if (show) {
            self.countDown -= 1
            self.show = false
        }
        
        self.timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    }
    
    func pause() {
        self.timer.upstream.connect().cancel()
        self.running = true
    }
    
    func playOrPause() {
        if (isPlaying) {
            self.timer.upstream.connect().cancel()
            self.isPlaying = false
        } else {
            self.timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
            self.countDown -= 1
            self.isPlaying = true
        }
    }
}

struct IndoorExercise_Previews: PreviewProvider {
    static var previews: some View {
        IndoorExercise()
    }
}
