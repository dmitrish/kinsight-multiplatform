//
//  IdeaViewDetail.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 11/25/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI
import SharedCode

struct IdeaViewDetail: View {
    var ideaModel: IdeaModel

    var body: some View {

        ZStack {
            Text(ideaModel.securityName).font(.headline)
            Text("Alpha: \(ideaModel.alpha)" )
            Text("Entry price: \(ideaModel.entryPrice)" )
            Text("Target price: \(ideaModel.targetPrice)" )
            Text("Time Horizon: \(ideaModel.timeHorizon)" )
            GraphView()
        }


    }
}

struct IdeaViewDetail_Preview: PreviewProvider {



    static var previews: some View {
        IdeaViewDetail(ideaModel:  IdeaSample.sharedInstance.ideaModelSample  )
    }


}
