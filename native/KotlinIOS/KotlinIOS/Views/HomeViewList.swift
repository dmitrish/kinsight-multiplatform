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
        UINavigationBar.appearance().backgroundColor = UIColor.init(hex: bkDark)
        UITableView.appearance().backgroundColor = UIColor.init(hex: bkDark)
        UITableViewCell.appearance().backgroundColor = UIColor.init(hex: bkDark)
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorColor = .white
//
////        UITableView.appearance().backgroundColor = .clear
////        UITableViewCell.appearance().backgroundColor = .clear

    }

    var body: some View {

             ZStack{

                Color.init(hex: bkDark)
                     .edgesIgnoringSafeArea(.all)

               VStack{
                    ActivityIndicator(isAnimating: $ideaViewModel.dataRequestInProgress)

                }.zIndex(1)
                NavigationView {
               VStack {
//                    Text("My Team Ideas")
                    List(ideaViewModel.ideas){
                        idea in
                        NavigationLink(destination: IdeaView(ideaModel: idea)) {
                           HomeViewListRow(ideaModel: idea).listRowBackground(Color.init(hex: bkDark))
                        }

                    }

               }.zIndex(0)
                .background(Color.init(hex: bkDark))
                .foregroundColor(.white)
                .navigationBarTitle("My Team Ideas", displayMode: .inline)
                                  .navigationBarItems(trailing:
                                             Button("Add Idea") {
                                                 print("Add Idea Tapped")
                                             }
                                         )
                }
          

        }.background(Color.init(hex: bkDark))

    }
}

struct HomeList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XS"], id: \.self) { deviceName in
            HomeViewList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
