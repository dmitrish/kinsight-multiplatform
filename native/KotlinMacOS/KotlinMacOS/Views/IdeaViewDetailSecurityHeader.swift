//
//  IdeaViewDetailSecurityHeader.swift
//  TryMacOS
//
//  Created by Dmitri  on 12/13/19.
//  Copyright © 2019 spb. All rights reserved.
//

import SwiftUI
import SharedCode

struct IdeaViewDetailSecurityHeader: View {
    var ideaModel: IdeaModel
    
    var body: some View {
        VStack {
            Text(ideaModel.securityTicker).font(.largeTitle).foregroundColor(.white)
                .padding(.bottom)
                .frame(width: 300)
            Text("\(ideaModel.securityName)" ).foregroundColor(.white).padding(.bottom, 40)
        }
    }
}

struct IdeaViewDetailSecurityHeader_Previews: PreviewProvider {
    static var previews: some View {
        IdeaViewDetailSecurityHeader(ideaModel:  IdeaSample.sharedInstance.ideaModelSample  ).background(Color(.darkGray))
         }

}

