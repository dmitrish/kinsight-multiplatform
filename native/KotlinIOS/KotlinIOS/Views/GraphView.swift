//
//  GraphView.swift
//  KotlinIOS
//
//  Created by Lee, Mark on 11/11/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode

struct GraphView: View {

    var ideaModel: IdeaModel
    var ideaModelLogicDecorator: IdeaModelLogicDecorator
    
    init(ideaModel: IdeaModel) {
        self.ideaModel = ideaModel
        self.ideaModelLogicDecorator = IdeaModelLogicDecorator(ideaModel: ideaModel)
    }

    var body: some View {
        ZStack {
            AnimatedBackground()
            
            VStack {
                IdeaViewDetailSecurityHeader(ideaModel: ideaModel)
                .padding(.top, 20)
                
                Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color.white)
                .padding(.leading, 43)
                .padding(.trailing, 43)
                .padding(.bottom, 50)

                Text("Alpha").foregroundColor(.white)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
                Text(ideaModelLogicDecorator.getDisplayValueForAlpha())
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: 300)
                    .padding(.bottom, 60)
                
                Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color.white)
                .padding(.leading, 43)
                .padding(.trailing, 43)
                .padding(.bottom, 40)

                ChartView(ideaModel)
                    .foregroundColor(.gray)
                    .frame(width: 320.0, height: 240.0)
            }
        }
    }
}

struct GraphView_Preview: PreviewProvider {
    static var previews: some View {
        GraphView(ideaModel:  IdeaSample.sharedInstance.ideaModelSample)
    }
}
