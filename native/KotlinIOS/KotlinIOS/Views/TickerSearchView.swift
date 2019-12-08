//
//  TickerSearchView.swift
//  KotlinIOS
//
//  Created by Piyush Chhabra on 11/18/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode


struct TickerSearchView: View {
    
    
    @Binding public var selectedTicker: TickerModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selection = 0
    
    @State var gradient = [Color(hex: Colors().colorGradientStart), Color(hex: Colors().colorGradientCenter), Color(hex: Colors().colorGradientEnd)]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    
    init(selectedTicker: Binding<TickerModel>) {
        self._selectedTicker = selectedTicker
        UISearchBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorColor = .clear
        
    }
    
//     TickerSearchView()
    
//    init(selectedTicker: TickerModel){
//
//        UISearchBar.appearance().backgroundColor = .clear
//            UINavigationBar.appearance().backgroundColor = .clear
//            UITableView.appearance().backgroundColor = .clear
//            UITableViewCell.appearance().backgroundColor = .clear
//            UITableView.appearance().tableFooterView = UIView()
//            UITableView.appearance().separatorColor = .clear
//
//        }

    
    @ObservedObject var tickerSearchViewModel = TickerSearchViewModel.init(repository: IdeaRepository(baseUrl: Constants.htttpUrl))
    
    
    var body: some View {
        
        ZStack {
           AnimatedBackground()
        VStack {
            SearchBar(text: $tickerSearchViewModel.searchText)
            List(tickerSearchViewModel.tickers){
                ticker in
                
                
//                   NavigationLink(destination: TickerSearchView(selectedTicker: self.$selectedTicker)) {  Text("Search Ticker") }
//                  Text("\(ticker.symbol)")
                Button( action: {
                        self.selectedTicker = ticker
                        self.presentationMode.wrappedValue.dismiss()
                        
                }){
                    VStack {
                        HStack {
                           Text("\(ticker.symbol) (\(ticker.exchange))")
                            .font(.headline).padding(.top)
                            Spacer()
                        }
                        HStack {
                            Text("\(ticker.name)")
                                .font(.subheadline)
                                .padding(.bottom)
                            Spacer()
                        }
                                   
                    }
                }
                
            }.overlay(ProgressView()
            .opacity(tickerSearchViewModel.inProgress ? 1 : 0))
        }
        }.background(Color.clear).foregroundColor(Color.white)
    }
}

//struct TickerSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        TickerSearchView(selectedTicker: TickerModel.init(symbol: "", exchange: "", name: "", type: "", region: "", currency: "", isEnabled: false))
//    }
//}
