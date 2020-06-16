//
//  File.swift
//  bicalms
//
//  Created by Eko Cahyo on 01/06/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

struct WalkingExercise : View {
    
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
    @State var showFinish = false
    
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
                
                WalkingAnimation()
                    .frame(width: 360, height: 360, alignment: .center)
                    .clipShape(Circle())
                
            }
            .blur(radius: showAlert ? 30 : 0)
            .blur(radius: showFinish ? 30 : 0)
            
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
                    .accessibility(label: Text("Close"))
                                        .accessibility(hint: Text("To close current exercise"))

                }
                
                VStack(spacing: 460){
                    
                    VStack(spacing: 4){
                        
                        Text("Outdoor Exercise")
                            .font(.body)
                            .foregroundColor(Color("White50"))
                        
                        Text("Walking")
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
                                    
                                })
                                {
                                    Image(systemName: "play.fill")
                                        .frame(width: 96)
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                }
                                .accessibility(label: Text("Play"))
                                .accessibility(hint: Text("Show the example how to Walking"))
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
                                           .accessibility(label: Text("repeat"))
                                        
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
                                        .accessibility(label: self.isPlaying ? Text("pause") : Text("play"))



                                        Button(action: {
                                            self.showFinish.toggle()
                                        }) {
                                            Image(systemName: "stop.fill")
                                                .frame(width: 96)
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                        }
                                        .accessibility(label: Text("Stop"))
                                                                           .accessibility(hint: Text("To stop current walking exercise"))
                                    }
                                }
                            }
                        }
                            
                     .onReceive(timer) { (output) in
                        if self.countDown > 9 && self.isPlayingTutorial {
                            self.timer.upstream.connect().cancel()
                        }
                        
                        if self.countDown < 9 && self.isPlayingTutorial {
                            self.countDown -= 1
                        }

                        if (self.countDown == 0 && self.isPlayingTutorial) {
                            self.countDown = -2
                            self.isPlayingTutorial = false
                            self.isInitialExercise = true
                            self.playExercise()
                        }
                        
                        if self.countDown > -2 && self.isPlayingExercise {
                            self.countDown += 1

                        }
                    }
                }
                .blur(radius: showAlert ? 30 : 0)
                .blur(radius: showFinish ? 30 : 0)
                
                Spacer()
            }
            .blur(radius: showAlert ? 30 : 0)
            .blur(radius: showFinish ? 30 : 0)
            
            if showAlert {
                customAlertView1(showAlert: $showAlert, countDown: $countDown)
                
            }
            
            if showFinish {
                finishAlertView1(showFinish: $showFinish, countDown: $countDown)
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
            self.countDown += 1
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

struct WalkingExercise_Previews: PreviewProvider {
    static var previews: some View {
        WalkingExercise()
    }
}

struct customAlertView1 : View {
    
    @Binding var showAlert : Bool
    @Binding var countDown : Int
    //var timmer : Int
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
                        coreDataAddItem(excercise: "Walking on \(self.countDown) seconds")
                        self.showAlert.toggle()
                    }){
                        Text("Leave")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .frame(width: 120, height: 64)
                        .padding(.top, 8)
                    }
                    
                    Button(action: {
                        print("cancel")
                        self.showAlert.toggle()
                    }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(width: 120, height: 64)
                        .padding(.top, 8)
                        
                    }
                }
            }            
        }
        .frame(width: 280, height: 140)
        .background(Color("White75"))
        .cornerRadius(24)
    }
}

struct finishAlertView1 : View {
    
    @Binding var showFinish : Bool
    @Binding var countDown : Int
    var body: some View {
        
        ZStack {
            
            VStack {
                
                Text("Are you sure to finish ?")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color("Blue2"))
                .padding(.bottom, 8)
                .padding(.top, 32)
                
                Text("You've done great today")
                .font(.subheadline)
                .foregroundColor(Color("Blue2"))
                
                HStack{
                    Button(action: {
                        coreDataAddItem(excercise: "Walking on \(self.countDown) seconds")
                        self.showFinish.toggle()
                    }){
                        Text("Finish")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .frame(width: 120, height: 64)
                        .padding(.top, 8)
                    }
                    
                    Button(action: {
                        self.showFinish.toggle()
                    }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(width: 120, height: 64)
                        .padding(.top, 8)
                    }
                }
            }
        }
        .frame(width: 300, height: 140)
        .background(Color("White75"))
        .cornerRadius(24)
    }
}


class WalkingExerciseVHC: UIHostingController<WalkingExercise> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: WalkingExercise())
    }
}
