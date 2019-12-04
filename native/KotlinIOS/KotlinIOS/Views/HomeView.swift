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

    var body: some View {
        ZStack {
            AnimatedBackground()
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

