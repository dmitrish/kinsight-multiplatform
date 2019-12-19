//
//  IdeaViewDetailPriceBlock.swift
//  TryMacOS
//
//  Created by Dmitri on 12/13/19.
//  Copyright © 2019 spb. All rights reserved.
//

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
    var ideaModelLogicDecorator: IdeaModelLogicDecorator
    
    init(ideaModel: IdeaModel){
        self.ideaModel = ideaModel
        self.ideaModelLogicDecorator = IdeaModelLogicDecorator(ideaModel: ideaModel)
       
    }
    
    var body: some View {
         VStack (alignment: .leading){
            
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
                Text(ideaModelLogicDecorator.getDisplayValueForPrice(priceKind: PriceKind.target))
                       .foregroundColor(.white)
                    .padding(.leading, 43)
                       .font(.title)
                       Spacer()
                Text(ideaModelLogicDecorator.getDisplayValueForPrice(priceKind: PriceKind.current))
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

