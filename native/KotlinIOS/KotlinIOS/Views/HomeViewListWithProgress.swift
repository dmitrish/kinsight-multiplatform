//
//  HomeViewListWithProgress.swift
//  KotlinIOS
//
//  Created by Dmitri Shpinar on 11/28/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//


import Foundation
import SwiftUI
import SharedCode

struct HomeViewListWithProgress: View {
    
    @ObservedObject var ideaViewModel : IdeasViewModel
    @State var gradient = [Color(hex: Colors().colorGradientStart), Color(hex: Colors().colorGradientCenter), Color(hex: Colors().colorGradientEnd)]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    //@State var progress : ProgressModel?
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
  
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        UITableViewCell.appearance().selectedBackgroundView = backgroundView
        
        self.ideaViewModel = IdeasViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"))
        
        
        
       // self.progress = ideaViewModel.dataRequestInProgress
    }
    
    var body: some View {

        VStack {
            HStack {
                Image("fish").resizable().frame(width:36, height:36).padding(.leading, 15)
                Spacer()
//                Text("My Team Ideas")
//                    .foregroundColor(Color.yellow)
//                    //.font(.headline)
//                    .fontWeight(Font.Weight.semibold)
//                    .font(.system(size: 20))
//                    .padding(.trailing, 70)
                AddButton(destination: NewIdeaView()).padding(.trailing, 30)
                
            }
            List(ideaViewModel.ideasSortedByAlpha){
                idea in
                NavigationLink(destination: IdeaViewDetail(ideaModel: idea)) {
                    
                    HomeViewListRow(ideaModel: idea)
                }.background(Color.clear)
                    .foregroundColor(Color.white)

            }.background(Color.clear)
                
        }

    }
    
    
}
        


struct HomeViewListWithProgress_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XS"], id: \.self) { deviceName in
            HomeViewListWithProgress()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }.background(AnimatedBackground())
    }
}

