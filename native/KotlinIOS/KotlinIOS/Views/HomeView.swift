//
//  HomeView.swift
//  KotlinIOS
//
//  Created by Dmitri  on 10/13/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI
import SharedCode

struct HomeView: View {
    

    @State private var selection = 0
    
    @State var gradient = [Color(hex: Colors().colorGradientStart), Color(hex: Colors().colorGradientCenter), Color(hex: Colors().colorGradientEnd)]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    
    var body: some View {
        
      
       
        ZStack {
            AnimatedBackground()
           // RoundedRectangle(cornerRadius: 0)
           // Image("screenbg").resizable().scaledToFill()
                             /*.fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))*/
                             //.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
       
                HomeViewList()
            }
                
        }.padding (.top, 0)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }

}

struct HomeView_Preview: PreviewProvider {
    
    
    
    static var previews: some View {
        HomeView()
    }
}

