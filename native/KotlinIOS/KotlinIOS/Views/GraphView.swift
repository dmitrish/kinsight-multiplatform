//
//  GraphView.swift
//  KotlinIOS
//
//  Created by Lee, Mark on 11/11/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode

class GraphProgressModel : ObservableObject {
    var inProgress = true
}

public class GraphViewModel : ObservableObject {
    
    @Published var graphModel: GraphModel?
    @Published var dataRequestInProgress = ProgressModel()
    @Published var inProgress : Bool = true
    
    private let repository: IdeaRepository?
    private let ideaModel: IdeaModel?
    
    init(repository: IdeaRepository, ideaModel: IdeaModel) {
        self.repository = repository
        self.ideaModel = ideaModel
        fetchKotlin()
    }
    
    func fetchKotlin() {
        dataRequestInProgress.inProgress = true
        
        if let ideaId = ideaModel?.id {
            repository?.fetchGraph(ideaId: ideaId, success: { data in
                self.graphModel = data
                self.dataRequestInProgress.inProgress = false
            })
        }
    }
}

struct GraphView: View {
    var ideaModel: IdeaModel
    var ideaModelLogicDecorator: IdeaModelLogicDecorator
    var graphViewModel: GraphViewModel?
    
    init(ideaModel: IdeaModel) {
        self.ideaModel = ideaModel
        self.ideaModelLogicDecorator = IdeaModelLogicDecorator(ideaModel: ideaModel)
        graphViewModel = GraphViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"), ideaModel: ideaModel)
    }

    var body: some View {
        ZStack {
            AnimatedBackground()
            
            VStack {
                IdeaViewDetailSecurityHeader(ideaModel: ideaModel)
                
                Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color.white)
                .padding(.leading, 43)
                .padding(.trailing, 43)
                .padding(.bottom, 25)

                Text("Alpha" ).foregroundColor(.white).padding(.bottom, 10)
                Text(ideaModelLogicDecorator.getDisplayValueForAlpha()).font(.largeTitle).foregroundColor(.white)
                    .padding(.bottom)
                    .frame(width: 300)
                
                ZStack {
                    Path { path in
                        let width: CGFloat = 380
                        let height: CGFloat = 250
                        let y: CGFloat = 0
                        
                        path.move(to: CGPoint(x: Double(20.0), y: Double(y)))
                        path.addLine(to: CGPoint(x: Double(20.0), y: Double(y+height)))
                        path.addLine(to: CGPoint(x: Double(20.0+width), y: Double(y+height)))
                    }
                    .stroke(Color(red: 255.0/255.0, green: 255.0/255.0, blue: 204.0/255.0))
                    
                    getPath(graphViewModel?.graphModel?.benchmark, isBenchmark: true)
                        .stroke(lineWidth: CGFloat(2.0))
                        .fill(Color(red: 165.0/255.0, green: 170.0/255.0, blue: 180.0/255.0))
                    
                    getPath(graphViewModel?.graphModel?.ticker, isBenchmark: false)
                        .stroke(lineWidth: CGFloat(2.0))
                        .fill(Color(red: 88.0/255.0, green: 154.0/255.0, blue: 234.0/255.0))
                }
            }
        }
    }
    
    func getPath(_ tickModels: [TickModel]?, isBenchmark: Bool) -> Path {
        let benchmarkItems = graphViewModel?.graphModel?.benchmark ?? []
        let tickerItems = graphViewModel?.graphModel?.ticker ?? []
        let (minX, minY, scaleX, scaleY) = getScaleFactor(benchmarkItems, tickerItems)
        let items = isBenchmark ? benchmarkItems : tickerItems
        
        return Path { path in
            var index = 0
            var x: CGFloat = 0.0
            var y: CGFloat = 0.0

            for item in items {
                let vx = CGFloat(item.x)
                let vy = CGFloat(item.y)
                x = (vx-minX) * scaleX + 20.0
                y = (vy-minY) * scaleY + 70.0
                
                if index == 0 {
                    path.move(to: CGPoint(x: Double(x), y: Double(y)))
                }
                else {
                    path.addLine(to: CGPoint(x: Double(x), y: Double(y)))
                }
                index += 1
            }
        }
    }
    
    func getScaleFactor(_ benchmarkItems: [TickModel], _ tickerItems: [TickModel]) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        let width: CGFloat = 380
        let height: CGFloat = 250
        let items = benchmarkItems + tickerItems
        var minX: CGFloat = 0.0
        var isMinXSet = false
        var maxX: CGFloat = 0.0
        var isMaxXSet = false
        var minY: CGFloat = 0.0
        var isMinYSet = false
        var maxY: CGFloat = 0.0
        var isMaxYSet = false
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
            
        for item in items {
            x = CGFloat(item.x)
            y = CGFloat(item.y)
                    
            if isMinXSet {
                minX = min(x, minX)
            }
            else {
                isMinXSet = true
                minX = x
            }
                    
            if isMaxXSet {
                maxX = max(x, maxX)
            }
            else {
                isMaxXSet = true
                maxX = x
            }
                    
            if isMinYSet {
                minY = min(y, minY)
            }
            else {
                isMinYSet = true
                minY = y
            }
                    
            if isMaxYSet {
                maxY = max(y, maxY)
            }
            else {
                isMaxYSet = true
                maxY = y
            }
        }
            
        let scaleX: CGFloat = (CGFloat(width) / (maxX-minX))
        let scaleY: CGFloat = (CGFloat(height) / (maxY-minY))
        return (minX, minY, scaleX, 0.5*scaleY)
    }
}

struct GraphView_Preview: PreviewProvider {
    static var previews: some View {
        GraphView(ideaModel:  IdeaSample.sharedInstance.ideaModelSample)
    }
}
