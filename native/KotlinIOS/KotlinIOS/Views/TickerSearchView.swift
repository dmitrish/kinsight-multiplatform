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
    
    @ObservedObject var tickerSearchViewModel = TickerSearchViewModel.init(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"))
    
    
    var body: some View {
        VStack {
            SearchBar(text: $tickerSearchViewModel.searchText)
            List(tickerSearchViewModel.tickers){
                ticker in
                Text("\(ticker.symbol)")
            }
        }
    }
}

struct TickerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TickerSearchView()
    }
}
