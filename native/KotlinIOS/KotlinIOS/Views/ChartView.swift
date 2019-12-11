//
//  ChartView.swift
//  KotlinIOS
//
//  Created by Lee, Mark on 12/9/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode
import SceneKit

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
    
    let graphHeight: CGFloat = 200.0
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
                drawAlpha(context, 0.0, 256.0, width, 50.0)
                drawLine(context, 0.0, 410.0, width)
            }
            else {
                drawSecurityHeader(context, 0.0, -4.0, width, 50.0, isHorizontal: true, textAlignment: .left)
                drawAlpha(context, 0.0, -2.0, width, 50.0, isHorizontal: true, textAlignment: .right)
            }

            drawChartLegend(context, 0.0, height-graphHeight-34.0, width, 50.0, textAlignment: .left)
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
        let dy: CGFloat = graphHeight / 6.0
        var y: CGFloat = height-dy
        
        for _ in 1...6 {
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
        let (minX, minY, scaleX, scaleY) = ChartNativeView.getScaleFactor(benchmarkItems, tickerItems, width, graphHeight)
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
            y = (vy-minY) * scaleY + (0.25*graphHeight)

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
    
    static func getScaleFactor(_ benchmarkItems: [TickModel], _ tickerItems: [TickModel], _ width: CGFloat, _ height: CGFloat) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
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
        animationTimer = Timer.scheduledTimer(timeInterval: (1.0/60.0), target: self, selector: #selector(stepAnimationTimer), userInfo: nil, repeats: true)
    }
    
    @objc func stepAnimationTimer() {
        chartFraction = chartFraction + 0.015
        setNeedsDisplay()
        if chartFraction >= 1.0 {
            animationTimer?.invalidate()
        }
    }
}

struct ChartViewControllerWrapper: UIViewControllerRepresentable {

    typealias UIViewControllerType = ChartViewController

    var ideaModel: IdeaModel?
    
    init(_ ideaModel: IdeaModel?) {
        self.ideaModel = ideaModel
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ChartViewControllerWrapper>) -> ChartViewControllerWrapper.UIViewControllerType {
        return ChartViewController(ideaModel)
    }

    func updateUIViewController(_ uiViewController: ChartViewControllerWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<ChartViewControllerWrapper>) {
    }
}

class ChartViewController: UIViewController {
    
    let graphHeight: CGFloat = 200.0
    var chartFraction: CGFloat = 0.0
    var animationTimer: Timer?

    var ideaModel: IdeaModel?
    var ideaModelLogicDecorator: IdeaModelLogicDecorator?
    var graphViewModel: GraphViewModel?
    
    var sceneView = SCNView()

    convenience init(_ ideaModel: IdeaModel?) {
        self.init()
        self.ideaModel = ideaModel
        if let ideaModel = ideaModel {
            self.ideaModelLogicDecorator = IdeaModelLogicDecorator(ideaModel: ideaModel)
        }
        graphViewModel = GraphViewModel(repository: IdeaRepository(baseUrl: "http://35.239.179.43:8081"), ideaModel: ideaModel!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sceneView)

        let scene = SCNScene()
        let node = SCNNode()
        node.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        scene.rootNode.addChildNode(node)
        
        let axisColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let gridColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let benchmarkColor = UIColor(red: 88.0/255.0, green: 154.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        let tickerColor = UIColor(red: 216.0/255.0, green: 154.0/255.0, blue: 115.0/255.0, alpha: 1.0)
        
        addGrid(node, gridColor)
        addAxis(node, axisColor)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.addLineGraph(node, self.getGraphData(isBenchmark: true), 3.0, benchmarkColor)
            self.addLineGraph(node, self.getGraphData(isBenchmark: false), 3.0, tickerColor)
        }
        
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.automaticallyAdjustsZRange = true
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: Float(-0.15), y: Float(0.4), z: Float(0.5))
        cameraNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-30), y: GLKMathDegreesToRadians(-15), z: 0.0)
        scene.rootNode.addChildNode(cameraNode)

        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.clear
        sceneView.autoenablesDefaultLighting = true
    }
    
    func addAxis(_ node: SCNNode, _ color: UIColor) {
        let width: CGFloat = view.bounds.width
        addLine(node, 0.0, 0.0, width, 2.0, 2.0, UIColor.gray)
    }
    
    func addGrid(_ node: SCNNode, _ color: UIColor) {
        let width: CGFloat = view.bounds.width
        let dy: CGFloat = 36.0
        var y: CGFloat = dy
        
        for _ in 1...6 {
            addLine(node, 0.0, y, width, 1.0, 1.0, UIColor.gray)
            y += dy
        }
    }
    
    func addLine(_ node: SCNNode, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, _ length: CGFloat, _ color: UIColor) {
        let shape = SCNBox(width: width, height: height, length: length, chamferRadius: 0.0)
        shape.firstMaterial?.lightingModel = .physicallyBased
        shape.firstMaterial?.diffuse.contents = color
        shape.firstMaterial?.metalness.contents = 0.8
        shape.firstMaterial?.roughness.contents = 0.2
        let planeNode = SCNNode(geometry: shape)
        planeNode.position = SCNVector3Make(Float(x), Float(y), 0.0)
        node.addChildNode(planeNode)
    }
    
    func addLineGraph(_ node: SCNNode, _ dataList: [CGFloat], _ extrusionDepth: CGFloat, _ color: UIColor) {
        let width: CGFloat = view.bounds.width
        let graphPath = UIBezierPath()
        var x: CGFloat = 0.0
        let dx: CGFloat = width/CGFloat(dataList.count)
        var index = 0
        var y: CGFloat = 0.0
        let lineWidth: CGFloat = 5.0
        
        for value in dataList {
            y = CGFloat(value)
            
            if index == 0 {
                graphPath.move(to: CGPoint(x: x, y: y))
            }
            else {
                graphPath.addLine(to: CGPoint(x: x, y: y))
            }
            
            x += dx
            index += 1
        }

        for value in dataList.reversed() {
            x -= dx
            y = CGFloat(value)
            graphPath.addLine(to: CGPoint(x: x, y: y-lineWidth))
        }
        
        graphPath.close()

        let shape = SCNShape(path: graphPath, extrusionDepth: 1.0)
        shape.firstMaterial?.lightingModel = .physicallyBased
        shape.firstMaterial?.diffuse.contents = color
        shape.firstMaterial?.metalness.contents = 0.8
        shape.firstMaterial?.roughness.contents = 0.2
        let shapeNode = SCNNode(geometry: shape)
        shapeNode.position = SCNVector3(x: Float(-0.5*width), y: 0.0, z: 0.0);
        node.addChildNode(shapeNode)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    func getGraphData(isBenchmark: Bool) -> [CGFloat] {
        let width: CGFloat = view.bounds.width
        let benchmarkItems = graphViewModel?.graphModel?.benchmark ?? []
        let tickerItems = graphViewModel?.graphModel?.ticker ?? []
        let (_, minY, _, scaleY) = ChartNativeView.getScaleFactor(benchmarkItems, tickerItems, width, graphHeight)
        let items = isBenchmark ? benchmarkItems : tickerItems
        var y: CGFloat = 0.0
        var dataList: [CGFloat] = []
        
        for item in items {
            let vy = CGFloat(item.y)
            y = (vy-minY) * scaleY + (0.25*graphHeight)
            dataList.append(y)
        }
        return dataList
    }
}

