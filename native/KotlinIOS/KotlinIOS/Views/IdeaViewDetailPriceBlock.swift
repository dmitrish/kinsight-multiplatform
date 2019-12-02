//
//  IdeaViewDetailPriceBlock.swift
//  KotlinIOS
//
//  Created by Dmitri on 12/1/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode

struct IdeaViewDetailPriceBlock: View {
    
    var ideaModel: IdeaModel
    
    var body: some View {
         VStack (alignment: .leading){
            /* Text("PRICE" ).kerning(62).foregroundColor(.white).padding(.leading, 43).padding(.bottom, 20) */
           HStack (alignment: .top){
                   Text("Target")
                       .foregroundColor(.white)
                       .padding(.leading, 43)
                       Spacer()
                   Text("Current")
                       .foregroundColor(.white)
                       .padding(.trailing, 44)
               }.padding(.top, 20)
               HStack (alignment: .top){
                   Text("$" + String(format: "%.2f", ideaModel.targetPrice))
                       .foregroundColor(.white)
                       .padding(.leading, 43)
                       .font(.title)
                       Spacer()
                   Text("$" + String(format: "%.2f", ideaModel.currentPrice))
                       .foregroundColor(.white)
                       .padding(.trailing, 44)
                       .font(.title)
               }.padding(.top, 10)
        }
    }
    
}

struct IdeaViewDetailPriceBlock_Previews: PreviewProvider {
    static var previews: some View {
        IdeaViewDetailPriceBlock(ideaModel:  IdeaSample.sharedInstance.ideaModelSample  ).background(Color(.darkGray))
    }

}
