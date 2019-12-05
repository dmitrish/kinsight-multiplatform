//
//  IdeaViewDetailThesisBlock.swift
//  KotlinIOS
//
//  Created by Dmitri  on 12/1/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode

struct IdeaViewDetailThesisBlock: View {
    
    var ideaModel: IdeaModel
    
    var body: some View {
         VStack (alignment: .leading){
      
           HStack (alignment: .top){
                   Text("Horizon")
                       .foregroundColor(.white)
                       .padding(.leading, 43)
                       Spacer()
                   Text("Conviction")
                       .foregroundColor(.white)
                       .padding(.trailing, 44)
               }.padding(.top, 10)
               HStack (alignment: .top){
                Text(ideaModel.timeHorizon)
                       .foregroundColor(.white)
                       .padding(.leading, 43)
                    .font(.title)
                       Spacer()
                Text(ideaModel.convictionId == 1 ? "High" : (ideaModel.convictionId == 2 ? "Medium" : "Low"))
                       .foregroundColor(.white)
                       .padding(.trailing, 44)
                    .font(.title)
               }
        }
    }
    
}

struct IdeaViewDetailThesisBlock_Previews: PreviewProvider {
    static var previews: some View {
        IdeaViewDetailThesisBlock(ideaModel:  IdeaSample.sharedInstance.ideaModelSample  ).background(Color(.darkGray))
    }

}
