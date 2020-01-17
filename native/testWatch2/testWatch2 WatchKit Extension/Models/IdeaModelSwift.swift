//
//  IdeaModelSwift.swift
//  testWatch2 WatchKit Extension
//
//  Created by Dmitri Shpinar on 12/14/19.
//  Copyright © 2019 spb. All rights reserved.
//

import Foundation

struct IdeaModelSwift : Hashable, Identifiable, Codable {
    var id: Int32
 
    var securityTicker: String
    var securityName: String
    var absolutePerformance: Double
    var alpha: Double
    
   // var name: String?
  
    
   // var benchMarkEntryPrice: Double
    var benchMarkTicker: String
 //   var benchMarkTickerDesc: String
    var benchMarkCurrentPrice: Double
  //  var benchMarkClosePrice: Double
    var benchMarkPerformance: Double
  //  var comments: String?
    var convictionId: Int
 //   var currrentPrice: Double
    var direction: String
    var directionId: Int
    var reason: String
    var entryPrice: Double
    
 //   var securityId: Int
    var stopLoss: Double
    var stopLossValue: Double
  //  var stateId: Int
    var targetPrice: Double
    var targetPricePercentage: Double
   
    var timeHorizon: String
 
    var createdBy: String
    
}
