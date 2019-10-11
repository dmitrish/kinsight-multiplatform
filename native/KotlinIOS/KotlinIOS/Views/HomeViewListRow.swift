//
//  HomeViewListRow.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 10/11/19.


import Foundation
import SwiftUI

struct HomeViewListRow: View {
    
    var ideaModel: IdeaModel
   
    var body: some View {
        VStack (alignment:.leading) {
            Text(ideaModel.securityName).fontWeight(.bold)
            Text("Alpha: \(ideaModel.alpha)" )
        }.lineSpacing(4)
    }
    
    
}

