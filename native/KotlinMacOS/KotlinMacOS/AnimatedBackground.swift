//
//  AnimatedBackground.swift
//  TryMacOS
//
//  Created by Dmitri  on 12/12/19.
//  Copyright © 2019 spb. All rights reserved.
//

//
//  AnimatedBackground.swift
//  KotlinIOS
//
//  Created by Dmitri Shpinar on 11/26/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI


struct AnimatedBackground: View {
    
    
    @State var gradient = [Color.blue, Color.purple, Color.red]
       @State var startPoint = UnitPoint(x: 0, y: 0)
       @State var endPoint = UnitPoint(x: 0, y: 2)
       
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
        .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
        .edgesIgnoringSafeArea(.all)
//        .onAppear() {
//            withAnimation (Animation.easeInOut(duration: 5).repeatForever()){
//                self.startPoint = UnitPoint(x: 1, y: -1)
//                self.endPoint = UnitPoint(x: 0, y: 1)
//            }
//        }
    }
}

struct AnimatedBackground_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackground()
    }
}

