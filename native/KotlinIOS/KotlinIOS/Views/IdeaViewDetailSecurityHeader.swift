//
//  IdeaViewDetailSecurityHeader.swift
//  KotlinIOS
//
//  Created by Dmitri  on 12/1/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode

struct IdeaViewDetailSecurityHeader: View {
    var ideaModel: IdeaModel
    
    var body: some View {
        VStack {
            Image(ideaModel.direction == "Long" ? "bullmarket-2" : "bearmarket").resizable().frame(width: 28, height: 28)
                                       .padding(.top, 15).padding(.bottom, 7);
                                   Text(ideaModel.securityTicker).font(.largeTitle).foregroundColor(.white).padding(.bottom)
                                   Text("\(ideaModel.securityName)" ).foregroundColor(.white).padding(.bottom, 40)
        }
    }
}

struct IdeaViewDetailSecurityHeader_Previews: PreviewProvider {
    static var previews: some View {
        IdeaViewDetailSecurityHeader(ideaModel:  IdeaSample.sharedInstance.ideaModelSample  ).background(Color(.darkGray))
         }

}
