//
//  HomeView.swift
//  KotlinIOS
//
//  Created by Dmitri  on 10/13/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView: View {
    

    @State private var selection = 0
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor.init(hex: bkDark)
//        UIView.appearance().backgroundColor =  UIColor.init(hex: bkDark)
    }
    
    var body: some View {
        
        ZStack {
            Color.init(hex: bkDark)
                .edgesIgnoringSafeArea(.all)
            
            TabView{
               HomeViewList()
                    .tabItem {
                      Image(systemName: "1.circle")
                      Text("Kotlin View")
                    }.tag(0)
               HomeViewListNative()
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Native View")
                    }.tag(1)
            }.padding (.top, 5)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
        }.background(Color.init(hex: bkDark))
    }
}

struct HomeView_Preview: PreviewProvider {
    
    
    
    static var previews: some View {
        HomeView()
    }
}

