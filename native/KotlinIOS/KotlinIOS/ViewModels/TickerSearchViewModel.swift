//
//  TickerSearchViewModel.swift
//  KotlinIOS
//
//  Created by Piyush Chhabra on 11/18/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import SharedCode


extension TickerModel: Identifiable {
    
}

public class TickerSearchViewModel : ObservableObject {
    
    
    @Published var tickers = [TickerModel]()
    @Published var dataRequestInProgress = ProgressModel()
    @Published var searchText = "aapl"
    
    private var searchSubscriber: AnyCancellable!
      private var disposables = Set<AnyCancellable>()
    private let repository: IdeaRepository?
    
    
    init(repository: IdeaRepository) {
        self.repository = repository
        searchSubscriber = $searchText.removeDuplicates()
            .debounce(for: 0.8, scheduler: DispatchQueue.main)
            .sink(receiveValue: fetchTickers(for:))
    }
    
    
    func fetchTickers(for tickerString: String){
        dataRequestInProgress.inProgress = true
        
        self.repository?.fetchTickers(tickerFilter: tickerString, success: { (tickerModels) in
            
            self.tickers = tickerModels
            self.dataRequestInProgress.inProgress = false
            print("Ticker Values == \(self.tickers)")
            
        })
        
        
    }
    
    
    
    
}


