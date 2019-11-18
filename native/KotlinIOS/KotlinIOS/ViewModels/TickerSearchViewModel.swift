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


public class TickerSearchViewModel : ObservableObject {
    
    
    @Published var tickers = [TickerModel]()
    @Published var dataRequestInProgress = ProgressModel()
    
    private let repository: IdeaRepository?
    
    
    init(repository: IdeaRepository) {
        self.repository = repository
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
