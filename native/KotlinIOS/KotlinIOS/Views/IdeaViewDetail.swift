//
//  IdeaViewDetail.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 11/25/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI
import SharedCode

struct IdeaViewDetail: View {
    var ideaModel: IdeaModel
    
     @State var gradient = [Color(hex: Colors().colorGradientStart), Color(hex: Colors().colorGradientCenter), Color(hex: Colors().colorGradientEnd)]
     @State var startPoint = UnitPoint(x: 0, y: 0)
     @State var endPoint = UnitPoint(x: 0, y: 2)
    
    @State private var jiggle = false

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 0)
                                      .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                                      .edgesIgnoringSafeArea(.all)
                     VStack{
                        Image("undraw_fishing_hoxa")
                            .resizable().scaledToFit().frame(width: 400, height: 280, alignment: .topLeading)
                        .overlay(
                            VStack (alignment: .leading){
                                HStack {
                                    Image("man")
                                    .resizable()
                                        .frame(width: 72, height: 72)
                                       
                                }
                                .frame(width: 80, height: 80)
                                Text("Fisherman")
                                .foregroundColor(.white)
                                Text("Dmitri")
                                                               .foregroundColor(.white)
                                    .padding(.leading, 20)
                                    
                            }.padding(.leading, 210)
                                .padding(.bottom, 110)
                        )
                            
                            .overlay(
                                VStack{
                            HStack {
                                Image("fishyellow")
                                .resizable()
                                    .frame(width:72, height: 72)
                                    .padding(.top, 200)
                                    .padding(.leading, 38)
                                    .scaleEffect(jiggle ? 1.0 : 2.0)
                                    .animation(.interpolatingSpring(mass: 1, stiffness: 4, damping: 0.4, initialVelocity: 4))
                                    .onAppear(){
                                        self.jiggle.toggle()
                                }
                                Spacer()
                              
                            }
                                    Text(String(format: "%.2f", ideaModel.alpha))
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .font(.largeTitle)
                                        .padding(.trailing, 170)
                                    
                                    }
                                  
                            .padding()
                                 
                            
                        )
                        Spacer()
                        Text(ideaModel.securityTicker).font(.largeTitle).foregroundColor(.white).padding(.bottom)
                        Text("\(ideaModel.securityName)" ).foregroundColor(.white).padding(.bottom, 40)
                        Text("PRICE" ).kerning(64).foregroundColor(.white).padding(.leading, 43).padding(.bottom, 20)
                        VStack (alignment: .leading){
                            HStack (alignment: .top){
                                Text("Target")
                                    .foregroundColor(.white)
                                    .padding(.leading, 43)
                                    Spacer()
                                Text("Current")
                                     .foregroundColor(.white)
                                    .padding(.trailing, 44)
                            }.padding(.top, 30)
                            HStack (alignment: .top){
                                Text(String(format: "%.2f", ideaModel.targetPrice))
                                    .foregroundColor(.white)
                                    .padding(.leading, 43)
                                    .padding(.top, 30)
                                    Spacer()
                                Text(String(format: "%.2f", ideaModel.targetPrice))
                                     .foregroundColor(.white)
                                    .padding(.trailing, 44)
                                    .padding(.top, 30)
                            }
                        }
                        Spacer()
           
                    }
        }


    }
}

struct IdeaViewDetail_Preview: PreviewProvider {



    static var previews: some View {
        IdeaViewDetail(ideaModel:  IdeaSample.sharedInstance.ideaModelSample  )
    }


}
