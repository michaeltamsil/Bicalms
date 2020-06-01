//
//  IndoorExercise2B.swift
//  bicalms
//
//  Created by Eko Cahyo on 01/06/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//


import SwiftUI
import UIKit
import AVFoundation

struct IndoorExercise2B : View {
    
    @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State private var countDown = 4
    @State private var isPlaying = false
    @State private var isInitialTutorial = true
    @State private var isPlayingTutorial = false
    @State private var isInitialExercise = false
    @State private var isPlayingExercise = false
    @State private var progressColor3 = "Blue3"
    @State private var progressColor4 = "Blue4"
    
    var body: some View {

        ZStack{
            
            LinearGradient(gradient: .init(colors: [(Color("Blue2")), (Color("Blue1"))]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            ZStack{
                
                LinearGradient(gradient: .init(colors: [(Color(progressColor3)), (Color(progressColor4))]), startPoint: .top, endPoint: .bottom)
                    
                    .mask(
                        Circle()
                            .stroke(lineWidth: 5)
                            .padding()
                            .frame(width: 360, height: 360)
                    )
                
                IndoorAnimation2B()
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
                        
                        Text("02/10")
                            .font(.body)
                            .foregroundColor(Color("White50"))
                        
                        Text("Goofy Jacks (R)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                        
                        HStack{
                            
                            if (isInitialExercise || isInitialTutorial) {
                                Button(action: {
                                    if (self.isInitialExercise || self.isInitialTutorial) {
                                        self.play()
                                    } else {
                                        self.playOrPause()
                                    }
                                    
                                }) {
                                    Image(systemName: "play.fill")
                                        .frame(width: 96)
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }
                            } else {
                                
                                VStack {
                                    Text("\(countDown)")
                                        .frame(width: 96, height: 48)
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .background(Color("White10"))
                                        .cornerRadius(24)
                                        .padding(.bottom, 16)
                                        .padding(.top, 8)
                                        .onTapGesture() {
                                            
                                    }
                                    
                                    HStack {
                                        Image(systemName: "arrow.counterclockwise")
                                            .frame(width: 96)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        
                                        Button(action: {
                                            self.playOrPause()
                                        }) {
                                            if (self.isPlaying) {
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
                        if self.countDown > 9 && self.isPlayingTutorial {
                            // We don't need it when we start off
                            self.timer.upstream.connect().cancel()
                        }
                        
                        if self.countDown < 9 && self.isPlayingTutorial {
                            self.countDown -= 1
                        }

                        if (self.countDown == 0 && self.isPlayingTutorial) {
                            self.countDown = 17
                            self.isPlayingTutorial = false
                            self.isInitialExercise = true
                            self.playExercise()
                        }
                        
                        if self.countDown < 17 && self.isPlayingExercise {
                            self.countDown -= 1
                        }
                        
                        if self.countDown == 0 && self.isPlayingExercise {
                            self.timer.upstream.connect().cancel()
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    func play() {
        self.isPlaying = true
        
        if (self.isInitialTutorial) {
            self.playTutorial()
        }
    }
    
    func playTutorial() {
        
        if (isInitialTutorial) {
            self.isInitialTutorial = false
            self.countDown -= 1
        }
        
        self.isPlayingTutorial = true
        self.timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    }
    
    func playExercise() {
        self.progressColor3 = "Orange1"
        self.progressColor4 = "Orange3"
        
        if (isInitialExercise) {
            self.isInitialExercise = false
            self.countDown -= 1
        }
        
        self.isPlayingExercise = true
        self.timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    }
    
    func playOrPause() {
        if (isPlaying) {
            self.isPlaying = false
            self.timer.upstream.connect().cancel()
        } else {
            self.timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
            self.isPlaying = true
        }
    }
}

struct IndoorExercise2B_Previews: PreviewProvider {
    static var previews: some View {
        IndoorExercise2B()
    }
}
