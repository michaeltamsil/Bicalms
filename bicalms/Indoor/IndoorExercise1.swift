//
//  File.swift
//  bicalms
//
//  Created by Eko Cahyo on 31/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct IndoorExercise1 : View {
    
    @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State private var countDown = 4
    @State private var isPlaying = false
    @State private var isInitialTutorial = true
    @State private var isPlayingTutorial = false
    @State private var isInitialExercise = false
    @State private var isPlayingExercise = false
    @State private var nextExercise = false
    @State private var progressColor3 = "Blue3"
    @State private var progressColor4 = "Blue4"
    @State var showAlert = false
    
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
                
                IndoorAnimation1()
                    .frame(width: 360, height: 360, alignment: .center)
                    .clipShape(Circle())
            }
            .blur(radius: showAlert ? 30 : 0)
            
            VStack(spacing: 64){
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        self.showAlert.toggle()
                    }) {
                        Image(systemName: "xmark")
                        .frame(width: 64)
                        .padding(.top,40)
                        .font(.title)
                        .foregroundColor(.white)
                    }
                }
                
                VStack(spacing: 460){
                    
                    VStack(spacing: 4){
                        
                        Text("01/10")
                            .font(.body)
                            .foregroundColor(Color("White50"))
                        
                        Text("Toy Soldiers")
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
                                        
                                        Button(action: {
                                            self.resetExercise()
                                        }) {
                                        Image(systemName: "arrow.counterclockwise")
                                            .frame(width: 96)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        }
                                            
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
                                        
                                        .accessibility(label: Text(isPlaying ? "Play": "Pause"))
                                        .accessibility(hint: Text("run animation to show what kind of move"))

                                        
                                        Image(systemName: "info.circle")
                                            .frame(width: 96)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                            
                     .onReceive(timer) { (output) in
                        if self.countDown > 4 && self.isPlayingTutorial {
                            self.timer.upstream.connect().cancel()
                        }
                        
                        if self.countDown < 4 && self.isPlayingTutorial {
                            self.countDown -= 1
                        }

                        if (self.countDown == 0 && self.isPlayingTutorial) {
                            self.countDown = 32
                            self.isPlayingTutorial = false
                            self.isInitialExercise = true
                            self.playExercise()
                        }
                        
                        if self.countDown < 32 && self.isPlayingExercise {
                            self.countDown -= 1
                        }
                        
                        if self.countDown == 0 && self.isPlayingExercise {
                            self.timer.upstream.connect().cancel()
                            self.nextExercise = true

                        }
                    }
                }
                .blur(radius: showAlert ? 30 : 0)
                
                Spacer()
            }
            .blur(radius: showAlert ? 30 : 0)
            
            if showAlert {
                indoorAlertView1(showAlert: $showAlert,
                                 countDown: $countDown)
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
    
    func resetExercise() {
        self.isInitialTutorial = true
        self.isPlayingTutorial = false
        self.isInitialExercise = false
        self.isPlayingExercise = false
        self.timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
        self.countDown = 4
        self.progressColor3 = "Blue3"
        self.progressColor4 = "Blue4"
        self.isPlaying = false
    
    }
}

struct indoorAlertView1 : View {
    
    @Binding var showAlert : Bool
    @Binding var countDown: Int
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Text("Are you sure ?")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color("Blue2"))
                .padding(.bottom, 8)
                .padding(.top, 32)
                
                Text("You still can exercise later")
                .font(.subheadline)
                .foregroundColor(Color("Blue2"))
                
                HStack{
                    Button(action: {
                        coreDataAddItem(excercise: "Toy Soldiers on \(30 - self.countDown) seconds")
                        self.showAlert.toggle()
                    }){
                        Text("Leave")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .frame(width: 120, height: 64)
                        .padding(.top, 8)
                    }
                    
                    .accessibility(label: Text("Leave"))
                    .accessibility(hint: Text("To leave current exercise"))
                    
                    Button(action: {
                        self.showAlert.toggle()
                    }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(width: 120, height: 64)
                        .padding(.top, 8)
                    }
                    .accessibility(label: Text("Cancel"))
                    .accessibility(hint: Text("To continue Toy Soldiers exercise"))

                }
            }
        }
        .frame(width: 280, height: 140)
        .background(Color("White75"))
        .cornerRadius(24)
    }
}

struct IndoorExercise1_Previews: PreviewProvider {
    static var previews: some View {
        IndoorExercise1()
    }
}

class IndoorExerciseToyVHC: UIHostingController<IndoorExercise1> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: IndoorExercise1())
    }
}
