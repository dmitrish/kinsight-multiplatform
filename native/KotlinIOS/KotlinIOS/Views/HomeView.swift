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
    
    var body: some View {
       
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
    }
}

struct HomeView_Preview: PreviewProvider {
    
    
    
    static var previews: some View {
        HomeView()
    }
}

