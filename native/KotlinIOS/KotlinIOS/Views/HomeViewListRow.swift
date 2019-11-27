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
   
    var body: some View {

            HStack {
                VStack (alignment:.leading) {
                    Text(ideaModel.securityTicker)
                        .foregroundColor(Color.init(hex: white))
                        .fontWeight(.heavy)
                    Text(ideaModel.securityName)
                        //.foregroundColor(Color.init(hex: labeltext))
                        .foregroundColor(Color.init(hex: white))
                        .fontWeight(.bold)
                    Text("By: \(ideaModel.createdBy)")
                       // .foregroundColor(Color.init(hex: labeltext))
                        .foregroundColor(Color.init(hex: white))
                        .fontWeight(.bold)
                }
                Spacer()
                VStack (alignment:.trailing) {
                    HStack{
                        Image("fishyellow").resizable().frame(width: 40, height: 40)
                            .padding(.top, 20)
                            .padding(.trailing, -7)
                      Text( String(format: "%.2f", ideaModel.alpha))
                        .fontWeight(.bold)
                        .foregroundColor(Color.init(hex:(Colors().colorWhite)))
                       
                        
                    }
                    HStack{
                    
                                        Text( "φ")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.init(hex: white))
                    .padding(.top, -22)
                                        Text( String(format: "%.2f", ideaModel.alpha))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.init(hex: white))
                    .padding(.top, -20)
                                  }
                }
               
            }
            .lineSpacing(4)
            .padding(5)
            .background(Color.clear)
        
    }
}

struct HomeViewListRow_Preview: PreviewProvider {
   
    static var previews: some View {
        Group {
        HomeViewListRow(ideaModel: IdeaSample.sharedInstance.ideaModelSample)
        .previewLayout(.fixed(width: 400, height: 100
            )).background(AnimatedBackground())
        }
    }
}
//φ
