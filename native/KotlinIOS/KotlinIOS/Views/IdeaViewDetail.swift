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
    
    @State var gradient = [Color(hex: Colors().colorGradientStart), Color(hex: Colors().colorGradientCenter), Color(hex: Colors().colorGradientEnd)]
     @State var startPoint = UnitPoint(x: 0, y: 0)
     @State var endPoint = UnitPoint(x: 0, y: 2)

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 0)
                                      .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                                      .edgesIgnoringSafeArea(.all)
                     VStack{
                        Image("undraw_fishing_hoxa").resizable().scaledToFit().frame(width: 400, height: 280, alignment: .topLeading)
                        Spacer()
                        Text(ideaModel.securityTicker).font(.headline).foregroundColor(.white)
                        Text("\(ideaModel.securityName)" ).foregroundColor(.white)
            Text("Entry price: \(ideaModel.entryPrice)" ).foregroundColor(.white)
            Text("Target price: \(ideaModel.targetPrice)" ).foregroundColor(.white)
            Text("Time Horizon: \(ideaModel.timeHorizon)" ).foregroundColor(.white)
                    }
        }


    }
}

struct IdeaViewDetail_Preview: PreviewProvider {



    static var previews: some View {
        IdeaViewDetail(ideaModel:  IdeaSample.sharedInstance.ideaModelSample  )
    }


}
