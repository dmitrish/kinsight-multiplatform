//
//  HomeViewListRowNative.swift
//  KotlinIOS
//
//  Created by Dmitri on 10/13/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeViewListRowNative: View {
    
    var ideaModel: IdeaModelSwift
       
        var body: some View {
            VStack (alignment:.leading) {
                Text(ideaModel.securityName).fontWeight(.bold)
                Text("Alpha: \(ideaModel.alpha)" )
            }.lineSpacing(4)
        }
        
        
    }

