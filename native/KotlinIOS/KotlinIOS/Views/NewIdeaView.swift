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
                Text("Target Price: ") .padding()
                    .font(.headline)
                Spacer()
                
                VStack {
                    
                    
                    TextField("", text: $targetPrice).foregroundColor(.white) .padding(.leading, 43)
                        .padding(.trailing, 43)
                        .font(.headline)
                        .keyboardType(.numberPad)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.white)
                        .padding(.leading, 43)
                        .padding(.trailing, 43)
                }
                
            }
            HStack {
                Text("Stop  Loss   : ") .padding()
                    .font(.headline)
                Spacer()
                VStack {
                    TextField("", text: $stopLoss).foregroundColor(.white)
                        .padding(.leading, 43)
                        .padding(.trailing, 43)
                        .font(.headline)
                    .keyboardType(.numberPad)
                    Rectangle()
                        .frame(height: 1.0, alignment: .bottom)
                        .foregroundColor(Color.white)
                        .padding(.leading, 43)
                        .padding(.trailing, 43)
                }

            }
        }
    }
  
}

struct PickerView: View {
    
    
    init(direction: Binding<String>, duration: Binding<String>, conviction: Binding<String>) {
        self._duration = duration
        self._conviction = conviction
        self._direction = direction
        
//         .font: UIFont.boldSystemFont(ofSize: 24),
        
        UISegmentedControl.appearance().backgroundColor = UIColor.clear
        UISegmentedControl.appearance().layer.borderColor = UIColor.white.cgColor
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.lightGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 17)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white ,.font: UIFont.boldSystemFont(ofSize: 17)], for: .normal)
    }
    
    @Binding var direction: String
    @Binding var duration: String
    @Binding var conviction: String
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Direction: ")
                    .padding(.leading)
                    .padding(.top)
                    .font(.headline)
                Spacer()
            }
            
            Picker(selection: $direction, label: Text("")) {
                Text("Long").tag(0).foregroundColor(.white)
                    .font(.headline)
                Text("Short").tag(1).foregroundColor(.white)
                    .font(.headline)
            }.pickerStyle(SegmentedPickerStyle())
                .overlay( RoundedRectangle(cornerRadius: 12)
                                                                                                                .stroke(Color.white, lineWidth: 2)
            ).padding()
            
            
            HStack{
                Text("Conviction: ")
                    .padding(.leading)
                    .font(.headline)
                Spacer()
            }
            
            Picker(selection: $conviction, label: Text("")) {
                Text("High").tag(0).foregroundColor(.white)
                Text("Medium").tag(1).foregroundColor(.white)
                Text("Low").tag(2).foregroundColor(.white)
            }.pickerStyle(SegmentedPickerStyle())
                .overlay( RoundedRectangle(cornerRadius: 12)
                                                                                                                    .stroke(Color.white, lineWidth: 2)
                )
                .padding()
            HStack {
                Text("Duration: ")
                    .padding(.leading)
                    .font(.headline)
                Spacer()
            }
            
            Picker(selection: $duration, label: Text("")) {
                Text("1 week").tag(0).foregroundColor(.white)
                Text("1 month").tag(1).foregroundColor(.white)
                Text("3 months").tag(2).foregroundColor(.white)
            }.pickerStyle(SegmentedPickerStyle())
                .overlay( RoundedRectangle(cornerRadius: 12)
                                                                                                                    .stroke(Color.white, lineWidth: 2)
                )
                .padding()
        }
    }
}

struct NewIdeaView: View {

    var idearepo = IdeaRepository(baseUrl: Constants.htttpUrl)
    
    var randomPrice =  Int32 ((42...80).randomElement() ?? 0)
//     @Environment(\.presentationMode) var presentationMode

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
                
                HStack {
                    Image("fish")
                                  .resizable()
                        .frame(width:36, height:36, alignment: .leading)
                        .padding(.leading)
                    Spacer()
                    
                    Text("New Idea")
                    .foregroundColor(.white)
                        .padding()
                        .font(.largeTitle)
                    Spacer()
                    
                }.padding(.bottom)


                    HStack {
                        if(!self.selectedTicker.symbol.isEmpty) {
                            Text("\(self.selectedTicker.symbol) | Latest Price: \(randomPrice)" )
                                             .font(.headline).padding()
                                         Spacer()
                        }
             
                              }
                    
                    HStack {
                    
                    Button(action: {
                        self.showingTickerSearch.toggle()
                    }) {
                        HStack {
                            
                            Image(systemName: "magnifyingglass").padding(.leading)
                            Text(self.selectedTicker.symbol.isEmpty ? "Search Tickers": "\(self.selectedTicker.symbol)" )
                                                                      .padding()
                                                                      .font(.headline)
                            Spacer()
                                            
                                             
                        }
                       
               
//                        Text("Hacking with Swift")
//                        .padding()
//
//                        TextField(self.selectedTicker.symbol.isEmpty ? "Search Ticker": "\(self.selectedTicker.symbol)", text: $targetPrice).foregroundColor(.white) .padding(.leading, 43)
//                                               .padding(.trailing, 43)
//                                               .font(.headline)
 
                    }.sheet(isPresented: $showingTickerSearch) {
                       TickerSearchView(selectedTicker: self.$selectedTicker)
                    }
                    }
            

                TargetView(targetPrice: $targetPrice, stopLoss: $stopLoss)

                PickerView(direction: $direction, duration: $duration, conviction: $conviction)

                Button(
                    "Save Idea",
                    action: {
                        self.saveIdea()
                }
                ).padding()
                    .font(.headline)
                
              }.foregroundColor(.white)
    }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Success"), message: Text("Idea Saved"), dismissButton: .default(Text("Ok"), action: {
//                     self.presentationMode.wrappedValue.dismiss()
            }))
                       
        }
}
    
    func saveIdea() {

  let randomID = Int32((1...100000).randomElement() ?? 0)

        let ideaModel: IdeaModel = IdeaModel.init(id: randomID, securityName: selectedTicker.name, securityTicker: selectedTicker.symbol, alpha: 0.0, benchMarkTicker: "SPX", benchMarkCurrentPrice: 2856.66, benchMarkPerformance: 0.392, convictionId: 2, currentPrice: Double(randomPrice), direction: direction, directionId: 1, entryPrice: 24.59, reason: "Target Price", stockCurrency: "USD", stopLoss: Int32(stopLoss) ?? 0, stopLossValue: 313.4823, targetPrice: Double(targetPrice) ?? 0.0, targetPricePercentage: 0.0, timeHorizon: "1 week", createdBy: "Piyush", createdFrom: "iOS", previousCurrentPrice: 12.22, isActive: true, isPOAchieved: false, isNewIdea: false)
        
////        let ideaModel: IdeaModel = IdeaModel.init(id: randomID, securityName: selectedTicker.name, securityTicker: selectedTicker.symbol, alpha: 0.0, benchMarkTicker: "SPX", benchMarkCurrentPrice: 2856.66, benchMarkPerformance: 0.392, convictionId: 1, currentPrice: 24.59, direction: direction, directionId: 1, entryPrice: 24.59, reason:  "Target Price", stockCurrency: "USD", stopLoss: Int32(stopLoss) ?? 0, stopLossValue: 313.4823, targetPrice: Double(targetPrice) ?? 0.0, targetPricePercentage: 0.0, timeHorizon: duration, createdBy: "Piyush - from iOS", createdFrom: <#String#>, previousCurrentPrice: <#Double#>, isActive: <#Bool#>)
        
        idearepo.saveIdea(ideaModel: ideaModel, success: {
            print("Ideas Saved")
//                      self.showingAlert = true
            
        })
//        idearepo.saveIdea(ideaModel: ideaModel) {
//
//        }

    }
}

struct NewIdeaView_Previews: PreviewProvider {
    static var previews: some View {
        NewIdeaView()
    }
}
