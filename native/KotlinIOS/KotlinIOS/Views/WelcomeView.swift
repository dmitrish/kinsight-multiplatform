//
//  WelcomeView.swift
//  KotlinIOS
//
//  Created by Dmitri  on 10/14/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI
import SharedCode

struct WelcomeView: View {
    
    @State private var opacity = 0.0
    @State var textAlpha = 0.0
    @State var textScale: CGFloat = 1
    
    @State var gradient = [Color(hex: Colors().colorGradientStart), Color(hex: Colors().colorGradientCenter), Color(hex: Colors().colorGradientEnd)]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    
    @State var showWelcome = false
   
    
   var body: some View {
    NavigationView {
        ZStack {
            
            
            
        RoundedRectangle(cornerRadius: 0)
            .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                withAnimation (.easeInOut(duration: 5)){
                    self.startPoint = UnitPoint(x: 1, y: -1)
                    self.endPoint = UnitPoint(x: 0, y: 1)
                }
            }
 
             VStack {
                Spacer()
                   Image("fish")
                   NavigationLink(destination: HomeView()) {
                        WelcomeText()
                   
                    }
               
                
                Spacer()

                HStack { Spacer() }
               
                }.navigationBarHidden(true)
                
                .onAppear(){
                   withAnimation(.easeIn(duration: 3)){
                    self.showWelcome.toggle()
                    
                  }
                     
               }
          HStack { Spacer() }
        }
       
        }
  
    }
}

struct WelcomeText : View {
    
    @State var textAlpha = 0.0
    @State var textScale: CGFloat = 1
    var body: some View {
        
        return Text(Strings().welcomeMessage).foregroundColor(.white)
         .fontWeight(.bold)
         .opacity(textAlpha)
         .scaleEffect(textScale)
         .onAppear() {
            withAnimation (.linear(duration: 5)){
                self.runAnimations()
             }
         }
    }
    
    func runAnimations() {
           withAnimation(Animation.easeIn(duration: 4).delay(0.2)) {
            textAlpha = 1.0
            textScale = 1.2
        }
    }
}

struct WelcomeView_Preview: PreviewProvider {
    
    
    
    static var previews: some View {
        WelcomeView()
    }
}




