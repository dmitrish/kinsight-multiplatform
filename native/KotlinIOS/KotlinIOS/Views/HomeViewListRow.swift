//
//  HomeViewListRow.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 10/11/19.


import Foundation
import SwiftUI
import SharedCode

struct HomeViewListRow: View {
    
    var ideaModel: IdeaModel
   
    var body: some View {
        VStack (alignment:.leading) {
                Text(ideaModel.securityName).fontWeight(.bold)
                Text("Alpha: \(ideaModel.alpha)" )
        }.background(Color.clear)
            .lineSpacing(4)
    }
}

struct HomeViewListRow_Preview: PreviewProvider {
   
    static var previews: some View {
        HomeViewListRow(ideaModel: IdeaSample.sharedInstance.ideaModelSample)
    }
}

