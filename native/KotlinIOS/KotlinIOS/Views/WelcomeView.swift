//
//  WelcomeView.swift
//  KotlinIOS
//
//  Created by Dmitri  on 10/14/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    
    @State private var opacity = 0.0
    @State var textAlpha = 0.0
    @State var textScale: CGFloat = 1
    
    @State var gradient = [Color.blue, Color.purple, Color.orange]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    
    @State var showWelcome = false
    
    
   var body: some View {
    NavigationView {
        ZStack{
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
                   NavigationLink(destination: HomeView()) {
                    if showWelcome{
                    Text("Happy Alpha Fishing!")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .transition(.opacity)
                        }
                
                    }
                }.navigationBarHidden(true)
                .onAppear(){
                    self.showWelcome = true
                }
            }
        }
    }
}
