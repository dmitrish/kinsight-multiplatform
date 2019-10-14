//
//  HomeViewListNative.swift
//  KotlinIOS
//
//  Created by Dmitri on 10/13/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeViewListNative: View {
    @ObservedObject var ideaViewModel = IdeasViewModel()
    
    var body: some View {
        VStack {
            Text("Native iOS")
            
            List(ideaViewModel.ideasOriginal) {
                idea in
                //Text(idea.securityName)
               HomeViewListRowNative(ideaModel: idea)
            }
 
 
 
 
 
        }
    }
}
   
