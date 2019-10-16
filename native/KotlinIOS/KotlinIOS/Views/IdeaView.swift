//
//  IdeaView.swift
//  KotlinIOS
//
//  Created by Dmitri on 10/15/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI
import SharedCode

struct IdeaView: View {
    var ideaModel: IdeaModel
    
    var body: some View {
        VStack {
            
            Text(ideaModel.securityName).font(.headline)
            Text("Alpha: \(ideaModel.alpha)" )
            Text("Entry price: \(ideaModel.entryPrice)" )
            Text("Target price: \(ideaModel.targetPrice)" )
            Text("Time Horizon: \(ideaModel.timeHorizon)" )
 
        }
    }
}
