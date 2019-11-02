//
//  SampleIdeaModel.swift
//  KotlinIOS
//
//  Created by Dmitri on 10/27/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SharedCode

class IdeaSample {
    
    private init() { }
    
    static let sharedInstance = IdeaSample()

    let ideaModelSample: IdeaModel
        = IdeaModel(
            id: 1,
            securityName: "MSFT",
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
            createdBy: "Someone"
        )
}

