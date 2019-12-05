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
    
    init(repository: IdeaRepository) {
        self.repository = repository
        fetchKotlin()
    }
    
    func fetchKotlin() {
        dataRequestInProgress.inProgress = true
        inProgress = true
        let seconds = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.repository?.fetchGraph(ideaId: 12386, success: { data in
            self.graphModel = data
            self.dataRequestInProgress.inProgress = false
                self.inProgress = false
        })
        }
    }
}

struct GraphView: View {
    var ideaModel: IdeaModel
    
    @ObservedObject var graphViewModel = GraphViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"))
    
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

                IdeaViewDetailThesisBlock(ideaModel: ideaModel)
                IdeaViewDetailPriceBlock(ideaModel: ideaModel).padding(.bottom, 80)
                
                ZStack {
                    Path { path in
                        let width: CGFloat = 380
                        let height: CGFloat = 250
                        
                        var y: CGFloat = 50.0
                        let dy: CGFloat = 50.0

                        while y < height {
                            path.move(to: CGPoint(x: Double(20.0), y: Double(y)))
                            path.addLine(to: CGPoint(x: Double(20.0+width), y: Double(y)))
                            y += dy
                        }
                    }
                    .stroke(Color(red: 64.0/255.0, green: 70.0/255.0, blue: 79.0/255.0))
                    
                    getPath(graphViewModel.graphModel?.benchmark, isBenchmark: true)
                        .stroke(lineWidth: CGFloat(2.0))
                        .fill(Color(red: 165.0/255.0, green: 170.0/255.0, blue: 180.0/255.0))
                    
                    getPath(graphViewModel.graphModel?.ticker, isBenchmark: false)
                        .stroke(lineWidth: CGFloat(2.0))
                        .fill(Color(red: 88.0/255.0, green: 154.0/255.0, blue: 234.0/255.0))
                }
            }
        }
    }
    
    func getPath(_ tickModels: [TickModel]?, isBenchmark: Bool) -> Path {
        let benchmarkItems = graphViewModel.graphModel?.benchmark ?? []
        let tickerItems = graphViewModel.graphModel?.ticker ?? []
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
                y = (vy-minY) * scaleY
                
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
        return (minX, minY, scaleX, scaleY)
    }
}

struct GraphView_Preview: PreviewProvider {
    static var previews: some View {
        GraphView(ideaModel:  IdeaSample.sharedInstance.ideaModelSample)
    }
}
