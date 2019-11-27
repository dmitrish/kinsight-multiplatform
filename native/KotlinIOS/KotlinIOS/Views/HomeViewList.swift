//
//  HomeViewList.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 10/11/19.


import Foundation
import SwiftUI
import SharedCode


struct AddButton<Destination : View>: View {

    var destination:  Destination

    var body: some View {
        NavigationLink(destination: self.destination) { Image(systemName: "plus") }
    }
}

struct HomeViewList: View {
    
    @ObservedObject var ideaViewModel = IdeasViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"))
    @State var gradient = [Color(hex: Colors().colorGradientStart), Color(hex: Colors().colorGradientCenter), Color(hex: Colors().colorGradientEnd)]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
  
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        UITableViewCell.appearance().selectedBackgroundView = backgroundView
    }
    
    var body: some View {

        VStack {
            HStack {
                Image("fish").resizable().frame(width:30, height:30).padding(.leading, 10)
                Spacer()
                Text("My Team Ideas").foregroundColor(Color.white).font(.title).padding(.trailing, 60)
                AddButton(destination: TickerSearchView()).padding(.trailing, 30)
                
            }
            List(ideaViewModel.ideasSortedByAlpha){
                idea in
                NavigationLink(destination: IdeaViewDetail(ideaModel: idea)) {
                    
                    HomeViewListRow(ideaModel: idea)
                }.background(Color.clear)
                    .foregroundColor(Color.white)

            }.background(Color.clear)
        }
//        }.navigationBarTitle("My Team Ideas", displayMode: .inline)
//            .navigationBarItems(trailing:
//
//        )
    }
    
    
}
        
//
//    }
//}

//              ZStack{
                
//                 LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint)
//                 .edgesIgnoringSafeArea(.all)
//                 .zIndex(0)
//                VStack{
//                     ActivityIndicator(isAnimating: $ideaViewModel.dataRequestInProgress)

//                 }.zIndex(1)
//                 NavigationView {
//                VStack {
// //                    Text("My Team Ideas")
//                     List(ideaViewModel.ideas){
//                         idea in
//                         NavigationLink(destination: IdeaView(ideaModel: idea)) {
//                            HomeViewListRow(ideaModel: idea)
//                         }

//                     }

//                }.zIndex(0)
//                 .foregroundColor(.white)
//                 .navigationBarTitle("My Team Ideas", displayMode: .inline)
//                                   .navigationBarItems(trailing:
//                                            AddButton(destination: TickerSearchView())
//                                          )
   

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XS"], id: \.self) { deviceName in
            HomeViewList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }.background(AnimatedBackground())
    }
}
