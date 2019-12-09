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
            
            VStack {
                IdeaViewDetailSecurityHeader(ideaModel: ideaModel)
                .padding(.top, 20)
                
                Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color.white)
                .padding(.leading, 43)
                .padding(.trailing, 43)
                .padding(.bottom, 50)

                Text("Alpha").foregroundColor(.white)
                    .padding(.top, 40)
                    .padding(.bottom, 10)
                Text(ideaModelLogicDecorator.getDisplayValueForAlpha())
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: 300)
                
                Graph2DView(ideaModel)
                .frame(width: 320.0, height: 380.0)
            }
        }
    }
}

struct Graph2DView: UIViewRepresentable {
    
    var ideaModel: IdeaModel?
    
    init(_ ideaModel: IdeaModel?) {
        self.ideaModel = ideaModel
    }

    func makeUIView(context: Context) -> UIView {
        return Graph2DNativeView(ideaModel)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class Graph2DNativeView: UIView {
    
    var chartView: ChartNativeView?

    convenience init(_ ideaModel: IdeaModel?) {
        self.init(frame: CGRect.zero)
        let chartView = ChartNativeView(ideaModel)
        self.chartView = chartView
        self.addSubview(chartView)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        chartView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        chartView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        chartView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear
    }
}

struct GraphView_Preview: PreviewProvider {
    static var previews: some View {
        GraphView(ideaModel:  IdeaSample.sharedInstance.ideaModelSample)
    }
}
