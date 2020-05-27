//
//  IndoorExercise.swift
//  bicalms
//
//  Created by Eko Cahyo on 26/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI
import UIKit

struct IndoorExrecise : View {
    var body: some View {

        ZStack{
            
            LinearGradient(gradient: .init(colors: [(Color("Blue2")), (Color("Blue1"))]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
        VStack(spacing: 100){
            
            HStack{
                
                Spacer()
                Image(systemName: "xmark")
                    .frame(width: 64)
                    .font(.title)
                    .foregroundColor(.white)
            }
        
            VStack(spacing: 80
            ){
                
                VStack(spacing: 4){
                    
                    Text("01/10") // Urutan Exercise
                        .font(.body)
                        .foregroundColor(Color("White50"))
                    
                    Text("Exercise Name") // Nama Exercise
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                ZStack{
                
                    LinearGradient(gradient: .init(colors: [(Color("Orange3")), (Color("Orange1"))]), startPoint: .top, endPoint: .bottom)
                        
                        .mask(
                            Circle()
                                .stroke(lineWidth: 5)
                                .padding()
                                .frame(width: 320, height: 320)
                        )
                        IndoorAnimation().frame(width: 300, height: 300, alignment: .center)
                            .clipShape(Circle())
                    
                }
                
                HStack{
                    
                    Image(systemName: "arrow.counterclockwise")
                        .frame(width: 96)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Image(systemName: "play.fill")
                        .frame(width: 96)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Image(systemName: "info.circle")
                        .frame(width: 96)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    }
                }
                Spacer()
            }
        }
    }
}

struct IndoorExercise_Previews: PreviewProvider {
    static var previews: some View {
        IndoorExrecise()
    }
}
