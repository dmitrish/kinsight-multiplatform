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
    
    init(ideaModel: IdeaModel){
        self.ideaModel = ideaModel
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }

    var body: some View {
        
        

        ZStack {
            RoundedRectangle(cornerRadius: 0)
                                      .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                                      .edgesIgnoringSafeArea(.all)
                     VStack{
                        Image("undraw_fishing_hoxa")
                            .resizable().scaledToFit().frame(width: 400, height: 250, alignment: .topLeading)
                            .padding(.leading, 20)
                        .overlay(
                            VStack (alignment: .leading){
                                HStack {
                                    Image(ideaModel.createdBy.lowercased())
                                    .resizable()
                                        .frame(width: 88, height: 88)
                                        .padding(.leading, 30)
                                       
                                }
                                .frame(width: 88, height: 88)
                                Text("Fisherman")
                                    .foregroundColor(.white)
                                    .padding(.leading, 15)
                                Text(ideaModel.createdBy)
                                    .foregroundColor(.white)
                                    .padding(.leading, 47)
                                    
                            }.padding(.leading, 240)
                                .padding(.bottom, 130)
                        )
                            
                            .overlay(
                                VStack{
                            HStack {
                                Image(ideaModel.alpha > 4 ? "fishgreen" : (ideaModel.alpha > 3 ? "fishyellow" : "fishred"))
                                .resizable()
                                    .frame(width:92, height: 92)
                                    .padding(.top, 207)
                                    .padding(.leading, 31)
                                    .scaleEffect(jiggle ? 1.0 : 2.0)
                                    .animation(.interpolatingSpring(
                                        mass: 10,
                                        stiffness: (ideaModel.alpha > 4 ? 50 : 150),
                                        damping: 5.9,
                                        initialVelocity: (ideaModel.alpha > 4 ? 5 : 2)
                                        )
                                    )
                                    
                                    .onAppear(){
                                        self.jiggle.toggle()
                                }
                                Spacer()
                              
                            }
                                    Text(String(format: "%.2f", ideaModel.alpha))
                                        .foregroundColor(.white)
                                        .fontWeight(Font.Weight.semibold)
                                        .font(.largeTitle)
                                        .padding(.trailing, 198)
                                        .padding(.top, -61)
                                    
                                    }
                                  
                            .padding()
                                 
                            
                        )
                        
                        Spacer()
                        
                      
                        NavigationLink(destination: GraphView()) {
                            
                            IdeaViewDetailSecurityHeader(ideaModel: ideaModel)
                        
                            /* Text("IDEA DETAIL" ).kerning(22).foregroundColor(.white).padding(.leading, 43).padding(.bottom, 20)
 */
                                               
                            Rectangle()
                                      .frame(height: 1.0, alignment: .bottom)
                                .foregroundColor(Color.white)
                                .padding(.leading, 43)
                                .padding(.trailing, 43)
                                .padding(.bottom, 25)

                            IdeaViewDetailThesisBlock(ideaModel: ideaModel)
                       
                            IdeaViewDetailPriceBlock(ideaModel: ideaModel).padding(.top, 20)
                        
                            Spacer()
                        }
           
                    }
        }


    }
}

struct IdeaViewDetail_Preview: PreviewProvider {



    static var previews: some View {
        IdeaViewDetail(ideaModel:  IdeaSample.sharedInstance.ideaModelSample  )
    }


}
