//
//  HomeViewList.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 10/11/19.


import Foundation
import SwiftUI
import SharedCode

struct HomeViewList: View {
    @ObservedObject var ideaViewModel = IdeasViewModel(repository: IdeaRepository())
    
    var body: some View {
         ZStack{
           VStack{
                ActivityIndicator(isAnimating: $ideaViewModel.dataRequestInProgress)
                                   
                              
            }.zIndex(1)
           VStack {

                    
                
                    Text(CommonKt.createApplicationScreenMessage())
                     
                    List(ideaViewModel.ideas){
                        idea in
                        HomeViewListRow(ideaModel: idea.ideaModel)
                    }
           }.zIndex(0)
           
        }
    }
}
   
