//
//  HomeViewList.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 10/11/19.


import Foundation
import SwiftUI
import SharedCode

struct HomeViewList: View {
    @ObservedObject var ideaViewModel = IdeasViewModel(repository: IdeaRepository(baseUrl: "https://alphacapture.appspot.com"))
    
    init() {
           UITableView.appearance().backgroundColor = .clear
           UITableViewCell.appearance().backgroundColor = .clear
       }
    
    var body: some View {
       
            // ZStack{
              /* VStack{
                    ActivityIndicator(isAnimating: $ideaViewModel.dataRequestInProgress)
                                       
                                  
                }.zIndex(1)*/
             //   NavigationView{
               VStack {
                Text("My Team Ideas").foregroundColor(Color.white).font(.title)
                List(ideaViewModel.ideas){
                        idea in
                        NavigationLink(destination: IdeaView(ideaModel: idea)) {
                           
                            HomeViewListRow(ideaModel: idea)
                        }.background(Color.clear)
                            .foregroundColor(Color.white)
                            
                      
                    }.background(Color.clear)
               }
               //.zIndex(0)
               // }.navigationBarHidden(true)
               // .navigationBarTitle("")
               
          //  }
       
    }
}
  
