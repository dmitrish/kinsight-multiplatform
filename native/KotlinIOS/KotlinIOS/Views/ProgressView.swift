//
//  ProgressView.swift
//  KotlinIOS
//
//  Created by Dmitri  on 11/28/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
   // @Binding var isAnimating : Bool
    @State var spinCircle = false

    var body: some View {
        ZStack {
            
            Circle()
               
                .trim(from: 0.3, to: 1)
                .stroke(Color.yellow, lineWidth:3)
                .frame(width:160)
           // .opacity(self.isAnimating ? 1 : 0)
                  .rotationEffect(.degrees(spinCircle ? 0 : -3360), anchor: .center)
                .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
                .overlay(Image("fish").resizable().frame(width:120, height: 120))
               
               // .opacity(self.isAnimating ? 1 : 0)
                   
            }
        .onAppear {
            self.spinCircle = true
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
       // ProgressView(isAnimating: .constant(true), //spinCircle: false)
        ProgressView()
    }
}
