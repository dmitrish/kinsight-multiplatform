//
//  ContentView.swift
//  TryMacOS
//
//  Created by Dmitri on 12/12/19.
//  Copyright © 2019 spb. All rights reserved.
//

import SwiftUI
import Foundation
import SharedCode

struct ContentView:  View {
    
     @ObservedObject var ideaViewModel = IdeasViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"))
    
   /* var ideaViewModel2 = IdeasViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"))*/
    
    let colors: [Color] = [.red, .green, .blue]
    
    init() {
          
          
         // let backgroundView = UIView()
        //  backgroundView.backgroundColor = UIColor.clear
          
        
         // progress = ideaViewModel.inProgress
          
         
      }
 

    var body: some View {
        ZStack {

            AnimatedBackground().overlay(
                VStack{
                HStack {
                       Image("fish")
                           .resizable()
                           .frame(width:36, height:36)
                           .padding(.leading, 10)
                               
                          
                    Spacer()
                    
                    Text("My Team Ideas").foregroundColor(Color.yellow)
                        //.font(.headline)
                        .fontWeight(Font.Weight.semibold)
                        .font(.system(size: 20))
                        .padding(.leading, 20)
                         Spacer()
                    }.padding()
                           
                
              ScrollView{
                VStack{
                    
                        ForEach(ideaViewModel.ideasSortedByAlpha, id: \.self) { idea in
                     HomeViewListRow(ideaModel: idea)
                        .padding(.top, -20)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                    }
                }.padding()
                      
                }
                }
                
            )
     
        }
    }
}

extension IdeaModel: Identifiable {
}


struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
