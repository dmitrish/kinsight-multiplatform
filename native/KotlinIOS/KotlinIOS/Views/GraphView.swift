//
//  GraphView.swift
//  KotlinIOS
//
//  Created by Lee, Mark on 11/11/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode

struct GraphView: View {

    var ideaModel: IdeaModel
    var ideaModelLogicDecorator: IdeaModelLogicDecorator
    
    init(ideaModel: IdeaModel) {
        self.ideaModel = ideaModel
        self.ideaModelLogicDecorator = IdeaModelLogicDecorator(ideaModel: ideaModel)
    }

    var body: some View {
        ZStack {
            AnimatedBackground()
            GraphViewControllerWrapper(ideaModel)
        }
    }
}

struct GraphViewControllerWrapper: UIViewControllerRepresentable {

    typealias UIViewControllerType = GraphViewController

    var ideaModel: IdeaModel?
    
    init(_ ideaModel: IdeaModel?) {
        self.ideaModel = ideaModel
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<GraphViewControllerWrapper>) -> GraphViewControllerWrapper.UIViewControllerType {
        return GraphViewController(ideaModel)
    }

    func updateUIViewController(_ uiViewController: GraphViewControllerWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<GraphViewControllerWrapper>) {
    }
}

class GraphViewController: UIViewController {
    
    var chartView: ChartNativeView?

    convenience init(_ ideaModel: IdeaModel?){
        self.init()

        let chartView = ChartNativeView(ideaModel)
        self.chartView = chartView
        view.addSubview(chartView)
        
        chartView.startAnimationTimer()
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43).isActive = true
        chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43).isActive = true
        chartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        chartView?.startAnimationTimer()
        chartView?.setNeedsDisplay()
    }
}

struct GraphView_Preview: PreviewProvider {
    static var previews: some View {
        GraphView(ideaModel:  IdeaSample.sharedInstance.ideaModelSample)
    }
}
