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
    var chartFraction: CGFloat = 0.0
    var animationTimer: Timer?

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
                    
            if width < height {
                drawSecurityHeader(context, 0.0, 46.0, width, 50.0)
                drawLine(context, 0.0, 180.0, width)
                drawAlpha(context, 0.0, 276.0, width, 50.0)
                drawLine(context, 0.0, 450.0, width)
            }
            else {
                drawSecurityHeader(context, 0.0, -4.0, width, 50.0, isHorizontal: true, textAlignment: .left)
                drawAlpha(context, 0.0, -2.0, width, 50.0, isHorizontal: true, textAlignment: .right)
            }

            drawChartLegend(context, 0.0, height-graphHeight-20.0, width, 50.0, textAlignment: .left)
            drawGrid(context, width, height)
            drawAxis(context, width, height)
            drawLineGraph(context, width, height, isBenchmark: true)
            drawLineGraph(context, width, height, isBenchmark: false)
        }
    }
    
    func drawChartLegend(_ context: CGContext, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, textAlignment: NSTextAlignment = .center) {
        let lineWidth: CGFloat = 20.0
        let securityName = ideaModel?.securityTicker ?? ""
        let vsText = "Vs"
        let font = UIFont.preferredFont(forTextStyle: .body)
        let textWidth = securityName.size(withAttributes: [NSAttributedString.Key.font: font]).width
        let textWidth2 = vsText.size(withAttributes: [NSAttributedString.Key.font: font]).width

        drawLegendLine(context, x, y+10.0, lineWidth, isBenchmark: false)
        drawText(context, x+lineWidth+8.0, y, width, height, securityName, .body, textAlignment: textAlignment)
        
        let x2 = x+30.0+textWidth+16.0
        drawText(context, x2, y, width, height, vsText, .body, textAlignment: textAlignment)
        
        let x3 = x2 + textWidth2 + 18.0
        drawLegendLine(context, x3, y+10.0, lineWidth, isBenchmark: true)
        drawText(context, x3+lineWidth+8.0, y, width, height, "S&P 500 Index", .body, textAlignment: textAlignment)
    }
    
    func drawSecurityHeader(_ context: CGContext, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, isHorizontal: Bool = false, textAlignment: NSTextAlignment = .center) {
        if isHorizontal {
            drawText(context, x, y, width, height, ideaModel?.securityTicker, .title1, textAlignment: textAlignment)
            drawText(context, x, y+38.0, width, height, ideaModel?.securityName, .body, textAlignment: textAlignment)
        }
        else {
            drawText(context, x, y, width, height, ideaModel?.securityTicker, .largeTitle, textAlignment: textAlignment)
            drawText(context, x, y+52.0, width, height, ideaModel?.securityName, .body, textAlignment: textAlignment)
        }
    }
    
    func drawAlpha(_ context: CGContext, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, isHorizontal: Bool = false, textAlignment: NSTextAlignment = .center) {
        if isHorizontal {
            drawText(context, x, y, width, height, "Alpha", .body, textAlignment: textAlignment)
            drawText(context, x, y+26.0, width, height, ideaModelLogicDecorator?.getDisplayValueForAlpha(), .title1, textAlignment: textAlignment)
        }
        else {
            drawText(context, x, y, width, height, "Alpha", .body, textAlignment: textAlignment)
                    drawText(context, x, y+30.0, width, height, ideaModelLogicDecorator?.getDisplayValueForAlpha(), .largeTitle, textAlignment: textAlignment)
        }
    }
    
    func drawText(_ context: CGContext, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, _ text: String?, _ textStyle: UIFont.TextStyle, textAlignment: NSTextAlignment = .center) {
        guard let text = text else {
            return
        }

        let font = UIFont.preferredFont(forTextStyle: textStyle)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle,
                          NSAttributedString.Key.foregroundColor: textColor]
        let string = NSAttributedString(string: text, attributes: attributes)
        string.draw(in: CGRect(x: x, y: y, width: width, height: height))
    }
    
    func drawLine(_ context: CGContext, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat) {
        context.setStrokeColor(textColor.cgColor)
        context.setLineWidth(1.0)
        context.move(to: CGPoint(x: x, y: y))
        context.addLine(to: CGPoint(x: x+width, y: y))
        context.strokePath()
    }
    
    func drawLegendLine(_ context: CGContext, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, isBenchmark: Bool) {
        let lineColor = isBenchmark ? benchmarkColor : tickerColor
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(4.0)
        context.move(to: CGPoint(x: x, y: y))
        context.addLine(to: CGPoint(x: x+width, y: y))
        context.strokePath()
    }
    
    func drawAxis(_ context: CGContext, _ width: CGFloat, _ height: CGFloat) {
        context.setStrokeColor(axisColor.cgColor)
        context.setLineWidth(1.5)
        context.move(to: CGPoint(x: 0.0, y: height))
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
        let totalCount = items.count
        
        context.setStrokeColor(lineColor.cgColor)
        context.setLineWidth(2.5)
        
        for item in items {
            let vx = CGFloat(item.x)
            let vy = CGFloat(item.y)
            let fraction = CGFloat(index) / CGFloat(totalCount)
            x = (vx-minX) * scaleX
            y = (vy-minY) * scaleY + 70.0
            
            if index == 0 {
                context.move(to: CGPoint(x: Double(x), y: Double(height-y)))
            }
            else if fraction <= chartFraction {
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
    
    func startAnimationTimer() {
        animationTimer?.invalidate()
        
        chartFraction = 0.0
        animationTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(stepAnimationTimer), userInfo: nil, repeats: true)
    }
    
    @objc func stepAnimationTimer() {
        chartFraction = chartFraction + 0.05
        setNeedsDisplay()
    }
}
