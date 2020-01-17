//
//  HomeViewListRow.swift
//  testWatch2 WatchKit Extension
//
//  Created by Dmitri Shpinar on 12/14/19.
//  Copyright © 2019 spb. All rights reserved.
//

//
//  HomeViewListRow.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 10/11/19.



// Colors



import Foundation
import SwiftUI
import SharedCode

let background = "#f7f9f9"
let regtext   = "#333333"
let labeltext = "#828995"
let green  = "#14c1a4"
let red = "#e86565"
let primaryblue =  "#59a2fd"
let backgrounddarkest  = "#e7e8ea"
let bkDark = "#2f3746"
let bkDarkDark = "#232b38"
let white = "#ffffff"

struct HomeViewListRow: View {

    var ideaModel: IdeaModel
    
    @State private var changeColor = false
   
    var body: some View {

            HStack {
                VStack (alignment:.leading) {
                    Text(ideaModel.securityTicker)
                        .foregroundColor(Color.white)
                        .fontWeight(.regular)
                   /* Text(ideaModel.securityName)
 
                        .foregroundColor(Color.white)
                        .fontWeight(.medium)*/
                    Text("\(ideaModel.createdBy)")
                       // .foregroundColor(Color.init(hex: labeltext))
                        .foregroundColor(Color.white)
                        .fontWeight(.thin)
                }
                Spacer()
                VStack (alignment:.trailing) {
                    HStack{
                        Image(ideaModel.alpha >= 4 ? "fishgreen" : (ideaModel.alpha >= 3 ? "fishyellow" : "fishred")).resizable().frame(width: 40, height: 40)
                            .padding(.top, 5)
                            .padding(.trailing, -7)
                            .padding(.leading, -22)
                        Text( ideaModel.alpha > 0 ? String(format: "%.2f", ideaModel.alpha): String(format: "%.1f", ideaModel.alpha))
                            .fontWeight(.light)
                            .foregroundColor(changeColor ? Color.green : Color.white)
                            .padding(.top, -15)
                            .padding(.trailing, 0)
                            .padding (.leading, -2)
                        .onAppear(){
                            withAnimation(.easeIn(duration: 1.0)){
                                if (self.ideaModel.alpha > 4){
                                    self.changeColor.toggle()
                                    let seconds = 2.0
                                          DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                             self.changeColor.toggle()
                                    }
                                }
                            }
                            
                        }
                       
                        
                    }
                    HStack{
                    
                                        Text( "φ")
                                            .fontWeight(.light)
                                            .foregroundColor(Color.white)
                    .padding(.top, -28)
                        Text( ideaModel.benchMarkPerformance > 0 ? String(format: "%.2f", ideaModel.benchMarkPerformance) : String(format: "%.1f", ideaModel.benchMarkPerformance))
                            .fontWeight(.light)
                            .foregroundColor(Color.white)
                    .padding(.top, -25)
                                  }
                }
               
            }
            .lineSpacing(4)
            .padding(.leading, 3)
            .padding(.trailing, 5)
            .background(Color.clear)
        
    }
}

struct HomeViewListRow_Preview: PreviewProvider {
   
    static var previews: some View {
        Group {
        Text("HI")
        }
        
        
    }
 
    
    /*
    static var previews: some View {
        ForEach(["Apple Watch Series 4 - 40mm", "Apple Watch Series 4 - 44mm"], id: \.self) { deviceName in
           HomeViewListRow(ideaModel: IdeaSample.sharedInstance.ideaModelSample)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }.background(AnimatedBackground())
    }
 */
}


