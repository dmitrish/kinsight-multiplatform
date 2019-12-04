//
//  NewIdeaView.swift
//  KotlinIOS
//
//  Created by Piyush Chhabra on 11/28/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode



extension TickerModel {
   
}
struct TargetView: View {

    @Binding var targetPrice: String
    @Binding var stopLoss: String
    
    var body: some View {
        
        VStack {
            HStack {
                             Text("Target Price: ")
                             Spacer()
                             TextField("Target Price: ", text: $targetPrice).foregroundColor(.white)
                                }
                         HStack {
                         Text("Stop Loss: ")
                             Spacer()
                         TextField("Stop Loss: ", text: $stopLoss).foregroundColor(.white)
                            }
               }
        }
  
}

struct PickerView: View {
   
    
    @Binding var direction: String
   @Binding var duration: String
    @Binding var conviction: String
   
    var body: some View {
        VStack {

                    Text("Direction: ")
                Picker(selection: $direction, label: Text("")) {
                          Text("Long").tag(0).foregroundColor(.white)
                          Text("Short").tag(1).foregroundColor(.white)
                      }.pickerStyle(SegmentedPickerStyle())
                        
                
                Text("Conviction: ")
                       Picker(selection: $conviction, label: Text("")) {
                                 Text("High").tag(0).foregroundColor(.white)
                                 Text("Medium").tag(1).foregroundColor(.white)
                                Text("Low").tag(2).foregroundColor(.white)
                             }.pickerStyle(SegmentedPickerStyle())
                
                Text("Duration: ")
            Picker(selection: $duration, label: Text("")) {
                                                  Text("1 week").tag(0).foregroundColor(.white)
                                                  Text("1 month").tag(1).foregroundColor(.white)
                                                 Text("3 months").tag(2).foregroundColor(.white)
                                              }.pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct NewIdeaView: View {

    var idearepo = IdeaRepository(baseUrl: Constants.htttpUrl)
    
//     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var selectedTicker: TickerModel = TickerModel.init(symbol: "", exchange: "", name: "", type: "", region: "", currency: "", isEnabled: true)
    
    @State private var securityTicker: String = "Tim"
//    @State private var targetPrice  = 0.00
//    @State private var stopLoss = 0.00
    
    @State private var targetPrice = ""
    @State private var stopLoss = ""
    @State private var direction = ""
     @State private var conviction = ""
     @State private var duration = ""
     @State private var showingAlert = false
     @State private var showingTickerSearch = false
    
    
    var body: some View {
        
        
//        let targetPriceProxy = Binding<String>(
//            get: { String(format: "%.02f", Double(self.targetPrice)) },
//                  set: {
//                      if let value = NumberFormatter().number(from: $0) {
//                        self.targetPrice =  value.doubleValue
//                      }
//                  }
//              )
//
//        let stopLossProxy = Binding<String>(
//               get: { String(format: "%.02f", Double(self.stopLoss)) },
//                     set: {
//                         if let value = NumberFormatter().number(from: $0) {
//                           self.stopLoss =  value.doubleValue
//                         }
//                     }
//                 )
        ZStack {
            AnimatedBackground()

              VStack {
//                Image("fish")
                HStack {
                    Text("Ticker: ")
                    Button(action: {
                        self.showingTickerSearch.toggle()
                    }) {
                       Text(self.selectedTicker.symbol.isEmpty ? "Search Ticker": "\(self.selectedTicker.symbol)" ) 
                    }.sheet(isPresented: $showingTickerSearch) {
                       TickerSearchView(selectedTicker: self.$selectedTicker)
                    }
                }

                Spacer()
                TargetView(targetPrice: $targetPrice, stopLoss: $stopLoss)
      
                Spacer()
                PickerView(direction: $direction, duration: $duration, conviction: $conviction)

                Spacer()
                Button(
                    "Save Idea",
                    action: {
                        self.saveIdea()
                }
                )
                
              }.foregroundColor(.white)
    }
//        .alert(isPresented: $showingAlert) {
//             Alert(title: Text("Success"), message: Text("Idea Save"), dismissButton: .default(Text("Ok")))
//                       
//        }
}
    
    func saveIdea() {

        let randomID = Int32((1...100000).randomElement() ?? 0)

        
        let ideaModel: IdeaModel = IdeaModel.init(id: randomID, securityName: selectedTicker.name, securityTicker: selectedTicker.symbol, alpha: 0.0, benchMarkTicker: "SPX", benchMarkCurrentPrice: 2856.66, benchMarkPerformance: 0.392, convictionId: 1, currentPrice: 24.59, direction: direction, directionId: 1, entryPrice: 24.59, reason: "Target Price", stockCurrency: "USD", stopLoss: Int32(stopLoss) ?? 0, stopLossValue: 313.4823, targetPrice: Double(targetPrice) ?? 0.0, targetPricePercentage: 0.0, timeHorizon: duration, createdBy: "Piyush - from iOS", createdFrom: "Piyush iOS ", previousCurrentPrice: 12.22, isActive: true)
//        let ideaModel: IdeaModel = IdeaModel.init(id: randomID, securityName: selectedTicker.name, securityTicker: selectedTicker.symbol, alpha: 0.0, benchMarkTicker: "SPX", benchMarkCurrentPrice: 2856.66, benchMarkPerformance: 0.392, convictionId: 1, currentPrice: 24.59, direction: direction, directionId: 1, entryPrice: 24.59, reason:  "Target Price", stockCurrency: "USD", stopLoss: Int32(stopLoss) ?? 0, stopLossValue: 313.4823, targetPrice: Double(targetPrice) ?? 0.0, targetPricePercentage: 0.0, timeHorizon: duration, createdBy: "Piyush - from iOS", createdFrom: <#String#>, previousCurrentPrice: <#Double#>, isActive: <#Bool#>)
        idearepo.saveIdea(ideaModel: ideaModel) {
//            self.showingAlert = true
//            self.presentationMode.wrappedValue.dismiss()
           
        }

    }
}

struct NewIdeaView_Previews: PreviewProvider {
    static var previews: some View {
        NewIdeaView()
    }
}
