//
//  OnBoarding.swift
//  bicalms
//
//  Created by Rifki Triaditiya Putra on 28/05/20.
//  Copyright © 2020 michael tamsil. All rights reserved.
//

import SwiftUI

struct OnBoarding: View {

    @State var Currentpage = 0
    var body: some View {
        
        ZStack {
        
        LinearGradient(gradient: .init(colors: [(Color("Blue2")), (Color("Blue1"))]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        
           

        VStack {
            
            VStack(spacing: 5) {
                           Text("Bicalms")
                               .font(.title)
                               .fontWeight(.heavy)
                               .foregroundColor(.white)
                               .multilineTextAlignment(.center)
                       }
            
            ZStack {
                            
                if Currentpage == 0 {
                    
                   Image("OnBoarding1").resizable().frame(width: 232.12, height: 297.23).cornerRadius(20).padding()
                }
                else if Currentpage == 1 {
                    
                    Image("OnBoarding2").resizable().frame(width: 228.11, height: 237.43).cornerRadius(20).padding()
                    
                }
                else if Currentpage == 2 {
                    
                    Image("OnBoarding3").resizable().frame(width: 283.65, height: 246.51).cornerRadius(20).padding()
                    
                }
            }
            VStack {
                
               if Currentpage == 0 {
                VStack(alignment: .center, spacing: 6) {
                  Text("Bicalms helps you relieve")
                    .foregroundColor(.white)
                  Text("the depressive symptoms")
                        .foregroundColor(.white)
                }
                .frame(width: 380, alignment: .center)
            }
                else if Currentpage == 1 {
                VStack(alignment: .center, spacing: 6) {
                      Text("Bicalms provides aerobics exercise")
                        .foregroundColor(.white)
                      Text("for your mental health")
                            .foregroundColor(.white)
                    }
                    .frame(width: 380, alignment: .center)
                }
                else if Currentpage == 2 {
                VStack(alignment: .center, spacing: 6) {
                      Text("Bicalms also organize your")
                        .foregroundColor(.white)
                      Text("exercise weekly")
                            .foregroundColor(.white)
                    }
                    .frame(width: 380, alignment: .center)
                }
            }
            pageControl(current: Currentpage)
            
            HStack{
                
                Button(action: {
                    
                    if self.Currentpage < 2 {
                        self.Currentpage += 1
                    }
                    
                }) {
                    
                    Text("Next")
                    
                }.frame(width: 200, height: 40).background(Color.orange).cornerRadius(20).foregroundColor(.white)
            }
            
            .padding()
        }.animation(.spring())
        
        
        }
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}

struct pageControl : UIViewRepresentable {
    
    var current = 0
    
    func makeUIView(context: UIViewRepresentableContext<pageControl>) -> UIPageControl  {
        
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .white
        page.numberOfPages = 3
        page.pageIndicatorTintColor = .gray
        return page
    }
    
    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<pageControl>) {
        
        uiView.currentPage = current
         
    }
}
