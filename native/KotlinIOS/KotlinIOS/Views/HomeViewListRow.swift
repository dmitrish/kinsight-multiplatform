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
        ZStack {
            HStack {
                VStack (alignment:.leading) {
                        Text(ideaModel.benchMarkTicker)
                            .foregroundColor(Color.init(hex: white))
                            .fontWeight(.heavy)
                        Text(ideaModel.securityName)
                    .foregroundColor(Color.init(hex: labeltext))
                    .fontWeight(.bold)
                }
                 Spacer()
                VStack (alignment:.trailing) {
                                      Text( String(format: "%.2f", ideaModel.alpha))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.init(hex:(Colors().colorGreen)))
                    
                                        Text( String(format: "%.2f", ideaModel.alpha))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.init(hex: red))
                                  }
               
            }
            .lineSpacing(4)
            .padding()
        }
    }
}

struct HomeViewListRow_Preview: PreviewProvider {
   
    static var previews: some View {
        HomeViewListRow(ideaModel: IdeaSample.sharedInstance.ideaModelSample)
        .previewLayout(.fixed(width: 400, height: 80
            ))
    }
}

