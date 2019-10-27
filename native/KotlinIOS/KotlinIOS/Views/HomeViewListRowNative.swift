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

struct HomeViewListRowNative_Preview: PreviewProvider {
    
    static var ideaModel = IdeaModelSwift(id: 3, securityName: "MSFT", absolutePerformance: 2.345, alpha: 2.45)
    
    static var previews: some View {
        HomeViewListRowNative(ideaModel: ideaModel)
    }
}

