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
    
    
    
    @State private var selection = 0
    
    @State var gradient = [Color(hex: Colors().colorGradientStart), Color(hex: Colors().colorGradientCenter), Color(hex: Colors().colorGradientEnd)]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    init(){
        
        
    
        UISearchBar.appearance().backgroundColor = .clear
            UINavigationBar.appearance().backgroundColor = .clear
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().tableFooterView = UIView()
            UITableView.appearance().separatorColor = .clear
        }

    
    @ObservedObject var tickerSearchViewModel = TickerSearchViewModel.init(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"))
    
    
    var body: some View {
        
        ZStack {
              RoundedRectangle(cornerRadius: 0)
                               .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                               .edgesIgnoringSafeArea(.all)
        VStack {
            SearchBar(text: $tickerSearchViewModel.searchText)
            List(tickerSearchViewModel.tickers){
                ticker in
                Text("\(ticker.symbol)")
            }
        }
        }.background(Color.clear).foregroundColor(Color.white)
    }
}

struct TickerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TickerSearchView()
    }
}
