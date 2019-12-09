//
//  ChartView.swift
//  KotlinIOS
//
//  Created by Lee, Mark on 12/9/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode

struct ChartView: UIViewRepresentable {
    
    var ideaModel: IdeaModel?
    
    init(_ ideaModel: IdeaModel?) {
        self.ideaModel = ideaModel
    }

    func makeUIView(context: Context) -> UIView {
        return ChartNativeView(ideaModel)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class ChartNativeView: UIView {
    
    let graphHeight: CGFloat = 240.0
    let textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let axisColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let gridColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let benchmarkColor = UIColor(red: 88.0/255.0, green: 154.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    let tickerColor = UIColor(red: 216.0/255.0, green: 154.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    
    var ideaModel: IdeaModel?
    var ideaModelLogicDecorator: IdeaModelLogicDecorator?
    var graphViewModel: GraphViewModel?
    
    convenience init(_ ideaModel: IdeaModel?) {
        self.init(frame: CGRect.zero)
        self.ideaModel = ideaModel
        if let ideaModel = ideaModel {
            self.ideaModelLogicDecorator = IdeaModelLogicDecorator(ideaModel: ideaModel)
        }
        graphViewModel = GraphViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"), ideaModel: ideaModel!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setNeedsDisplay()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.setNeedsDisplay()
        }
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let context = UIGraphicsGetCurrentContext() {
            let width = bounds.width
            let height = bounds.height
            
            drawSecurityHeader(context, width, height)
            drawLine(context, width, height, 180.0)
            drawAlpha(context, width, height)
            drawLine(context, width, height, 450.0)
            
            drawGrid(context, width, height)
            drawAxis(context, width, height)
            drawLineGraph(context, width, height, isBenchmark: true)
            drawLineGraph(context, width, height, isBenchmark: false)
        }
    }
    
    func drawSecurityHeader(_ context: CGContext, _ width: CGFloat, _ height: CGFloat) {
        drawText(context, width, height, 46.0, ideaModel?.securityTicker, .largeTitle)
        drawText(context, width, height, 98.0, ideaModel?.securityName, .body)
    }
    
    func drawAlpha(_ context: CGContext, _ width: CGFloat, _ height: CGFloat) {
        drawText(context, width, height, 276.0, "Alpha", .body)
        drawText(context, width, height, 306.0, ideaModelLogicDecorator?.getDisplayValueForAlpha(), .largeTitle)
    }
    
    func drawText(_ context: CGContext, _ width: CGFloat, _ height: CGFloat, _ offset: CGFloat, _ text: String?, _ textStyle: UIFont.TextStyle) {
        guard let text = text else {
            return
        }

        let font = UIFont.preferredFont(forTextStyle: textStyle)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle,
                          NSAttributedString.Key.foregroundColor: textColor]
        let string = NSAttributedString(string: text,
                                        attributes: attributes)
        string.draw(in: CGRect(x: 0.0, y: offset, width: width, height: 50.0))
    }
    
    func drawLine(_ context: CGContext, _ width: CGFloat, _ height: CGFloat, _ offset: CGFloat) {
        context.setStrokeColor(textColor.cgColor)
        context.setLineWidth(1.0)
        context.move(to: CGPoint(x: 0, y: offset))
        context.addLine(to: CGPoint(x: width, y: offset))
        context.strokePath()
    }
    
    func drawAxis(_ context: CGContext, _ width: CGFloat, _ height: CGFloat) {
        context.setStrokeColor(axisColor.cgColor)
        context.setLineWidth(1.5)
        context.move(to: CGPoint(x: 0, y: height))
        context.addLine(to: CGPoint(x: width, y: height))
        context.strokePath()
    }
    
    func drawGrid(_ context: CGContext, _ width: CGFloat, _ height: CGFloat) {
        let dy: CGFloat = 36.0
        let minY: CGFloat = height-graphHeight
        var y: CGFloat = height-dy
        
        while y >= minY {
            context.setStrokeColor(axisColor.cgColor)
            context.setLineWidth(0.25)
            context.move(to: CGPoint(x: 0, y: y))
            context.addLine(to: CGPoint(x: width, y: y))
            context.strokePath()
            y -= dy
        }
    }

    func drawLineGraph(_ context: CGContext, _ width: CGFloat, _ height: CGFloat, isBenchmark: Bool) {

        let benchmarkItems = graphViewModel?.graphModel?.benchmark ?? []
        let tickerItems = graphViewModel?.graphModel?.ticker ?? []
        let (minX, minY, scaleX, scaleY) = getScaleFactor(benchmarkItems, tickerItems, width, graphHeight)
        let items = isBenchmark ? benchmarkItems : tickerItems

        var index = 0
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        let lineColor = isBenchmark ? benchmarkColor : tickerColor
        
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(2.5)
        
        for item in items {
            let vx = CGFloat(item.x)
            let vy = CGFloat(item.y)
            x = (vx-minX) * scaleX
            y = (vy-minY) * scaleY + 70.0
            
            if index == 0 {
                context.move(to: CGPoint(x: Double(x), y: Double(height-y)))
            }
            else {
                context.addLine(to: CGPoint(x: Double(x), y: Double(height-y)))
            }
            index += 1
        }
        
        context.strokePath()
    }
    
    func getScaleFactor(_ benchmarkItems: [TickModel], _ tickerItems: [TickModel], _ width: CGFloat, _ height: CGFloat) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
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
