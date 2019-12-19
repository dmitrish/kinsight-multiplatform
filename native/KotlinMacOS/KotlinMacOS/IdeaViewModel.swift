//
//  IdeaViewModel.swift
//  TryMacOS
//
//  Created by Dmitri  on 12/13/19.
//  Copyright © 2019 spb. All rights reserved.
//

import Foundation
import SharedCode

public class IdeasViewModel : ObservableObject {
    
    @Published var ideas = [IdeaModel]()
    
  
    
    public var seletedIdea: IdeaModel = IdeaModel.init(id: Int32(0.0), securityName: "", securityTicker: "", alpha: 0.0, benchMarkTicker: "", benchMarkCurrentPrice: 0.0, benchMarkPerformance: 0.0, convictionId: Int32(0.0), currentPrice: 0.0, direction: "", directionId: 0, entryPrice: 0.0, reason: "", stockCurrency: "", stopLoss: 0, stopLossValue: 0.0, targetPrice: 0.0, targetPricePercentage: 0.0, timeHorizon: "", createdBy: "", createdFrom: "", previousCurrentPrice: 0.0, isActive: true, isPOAchieved: false, isNewIdea: false)
    
    private let repository: IdeaRepository?
      
    
    init(repository: IdeaRepository) {
        self.repository = repository
        

       loadIdeas()
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
           // self.loadIdeas()  // Put your code which should be executed with a delay here
        }
        
    }
    
    init() {
        self.repository = nil
        //dummy delay - to make sure progress indicator working
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
           // self.fetchNative()  // Put your code which should be executed with a delay here
        }

        
    }
    
    var ideasSortedByAlpha : [IdeaModel] {
        return ideas.filter{$0.isActive == true}.sorted {$0.alpha > $1.alpha}
    }
 
 
    
    public func loadIdeas() {
//        sendNotification()
        
        self.repository?.fetchIdeas(success: { data in
                       self.ideas  = data
                      

                      print(self.ideas)
               })
        
       /*  let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
       
            self.repository?.fetchIdeas(success: { data in
                self.ideas  = data
               

               print(self.ideas)
        })
        }
 */
    }
    
    
}

