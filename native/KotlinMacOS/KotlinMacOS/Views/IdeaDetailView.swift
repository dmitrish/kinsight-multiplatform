//
//  IdeaDetailView.swift
//  TryMacOS
//
//  Created by Dmitri  on 12/13/19.
//  Copyright © 2019 spb. All rights reserved.
//

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
    var ideaModelLogicDecorator: IdeaModelLogicDecorator
    var ideaRepo: IdeaRepository
    @State var gradient = [Color.blue, Color.purple, Color.red]
     @State var startPoint = UnitPoint(x: 0, y: 0)
     @State var endPoint = UnitPoint(x: 0, y: 2)
    
    @State private var jiggle = false
    
    init(ideaModel: IdeaModel , ideaRepo: IdeaRepository){
        self.ideaModel = ideaModel
        self.ideaRepo = ideaRepo
        self.ideaModelLogicDecorator = IdeaModelLogicDecorator(ideaModel: ideaModel)
       // UINavigationBar.appearance().barTintColor = .clear
      //  UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }

    var body: some View {
        
        

        ZStack {
            RoundedRectangle(cornerRadius: 0)
              .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
            //  .edgesIgnoringSafeArea(.all)
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
                                         .overlay(Circle().stroke(Color.white,lineWidth:2).shadow(radius: 10)) .padding(.leading, 70)
                                     .padding(.top, 40)
                                       
                                }
                                .frame(width: 88, height: 88)
                                
                                Text("Fisherman")
                                    .foregroundColor(.white)
                                    .padding(.leading, 45)
                                    .padding(.top, 15)
                               /* NavigationLink(destination:
                                    ZStack {
                                        AnimatedBackground()
                                       // Chart3DViewControllerWrapper()
                                    }
                                ) {
 */
                                Text(ideaModel.createdBy)
                                    .foregroundColor(.white)
                                    .padding(.leading, 77)
                                 //.padding(.top, 40)
                             /*   }*/
                                    
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
                                    Text(ideaModelLogicDecorator.getDisplayValueForAlpha())
                                        .foregroundColor(.white)
                                        .fontWeight(Font.Weight.semibold)
                                        .font(.largeTitle)
                                        .padding(.trailing, 198)
                                        .padding(.top, -61)
                                    
                                    }
                                  
                            .padding()
                                 
                            
                        )
                        
                        Spacer()
                        
                        Image(ideaModel.direction == "Long" ? "bullmarket-2" : "bearmarket").resizable().frame(width: 28, height: 28).padding(.top, 15).padding(.bottom, 7);
                        
                       // NavigationLink(destination: nil) {
                            VStack{
                                IdeaViewDetailSecurityHeader(ideaModel: ideaModel)

                                Rectangle()
                                    .frame(height: 1.0, alignment: .bottom)
                                    .foregroundColor(Color.white)
                                    .padding(.leading, 43)
                                    .padding(.trailing, 43)
                                    .padding(.bottom, 25)

                                IdeaViewDetailThesisBlock(ideaModel: ideaModel)
                                IdeaViewDetailPriceBlock(ideaModel: ideaModel).padding(.top, 20)
                        
                                Spacer()
                                
                                if(ideaModel.isPOAchieved) {
                                    Button(action: {
                                                            self.closeIdea(model: self.ideaModel)
                                                        }){
                                                            Image("ideaclose")
                                                                        .resizable().aspectRatio(contentMode: .fit)
                                                              //  .accentColor(.green)
                                                                       .frame(width: 36, height: 40, alignment: .trailing)
                                                                  .padding()
                                                                .overlay(Circle().stroke(Color.white,lineWidth:2).shadow(radius: 10)) .padding(.leading, 30)
                                                                     
                                                                     }
                                }
                    
                            }
                        }
 
           
                  //  }
        }.frame(width:480, height: 300).padding(.top, 25).padding(.bottom, 25)


    }
}


extension IdeaViewDetail {
    
    func closeIdea(model: IdeaModel) {
        
        self.ideaRepo.closeIdea(ideaModel: model) {
            print(" Idea Closed Successfully")
        }
    }
}

//
//extension  IdeaModelLogicDecorator {
//    var ideaRepo: IdeaRepository
//

//
//}

struct IdeaViewDetail_Preview: PreviewProvider {



    static var previews: some View {
        IdeaViewDetail(ideaModel:  IdeaSample.sharedInstance.ideaModelSample, ideaRepo: .init(baseUrl: "http://35.239.179.43:8081")  )
    }


}

