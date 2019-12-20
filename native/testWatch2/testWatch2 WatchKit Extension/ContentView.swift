//
//  ContentView.swift
//  testWatch2 WatchKit Extension
//
//  Created by Dmitri Shpinar on 12/14/19.
//  Copyright © 2019 spb. All rights reserved.
//
import Foundation
import SwiftUI
import SharedCode

struct ContentView: View {
    
    @ObservedObject var ideaViewModel = IdeasViewModel()
    
    init(){
       
               
    }
    
     
       /* var ideaModel  = IdeaModel(
                id: 1,
                securityName: "Microsoft Corp.",
                securityTicker: "MSFT",
                alpha: 2.3,
                benchMarkTicker: "SPX",
                benchMarkCurrentPrice:
                2.4,
                benchMarkPerformance: 2.7,
                convictionId: 1,
                currentPrice: 32.23,
                direction: "Long",
                directionId: 1,
                entryPrice: 31.23,
                reason: "Buy",
                stockCurrency: "USD",
                stopLoss: 2,
                stopLossValue: 5,
                targetPrice: 37,
                targetPricePercentage: 4,
                timeHorizon: "1 week",
                createdBy: "Dmitri",
                createdFrom: "iPhone",
                previousCurrentPrice: 32.23,
                isActive: true,
                isPOAchieved: false,
                isNewIdea: false
            )
 
 */
    
    var body: some View {
        AnimatedBackground().overlay(
            VStack{
                HStack {
                   Image("fish")
                        .resizable()
                        .frame(width:32, height:32)
                        .padding(.leading, -4)
                    Spacer()
                    Text("My Team Ideas").foregroundColor(Color.yellow)
                        //.font(.headline)
                        .fontWeight(Font.Weight.semibold)
                        .font(.system(size: 18))
                        .padding(.leading, 0)
                         Spacer()
                }.padding()
                List(ideaViewModel.ideas){
                    idea in
                        HomeViewListRow(ideaModel: idea)
                }
            }
                  
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
