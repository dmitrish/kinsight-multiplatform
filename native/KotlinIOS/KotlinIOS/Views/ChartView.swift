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
    
    let axisColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let gridColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let benchmarkColor = UIColor(red: 88.0/255.0, green: 154.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    let tickerColor = UIColor(red: 216.0/255.0, green: 154.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    
    let graphHeight: CGFloat = 200.0
    var chartFraction: CGFloat = 0.0
    var chartAnimationTimer: Timer?

    var ideaModel: IdeaModel?
    var ideaModelLogicDecorator: IdeaModelLogicDecorator?
    var graphViewModel: GraphViewModel?
    
    var sceneView = SCNView()
    var sceneNode: SCNNode?
    var benchmarkNode: SCNNode?
    var tickerNode: SCNNode?

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
        sceneNode = SCNNode()

        if let node = sceneNode {
            node.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
            scene.rootNode.addChildNode(node)
            addSecurityHeader(node)
            addAlpha(node)
            addGrid(node, gridColor)
            addAxis(node, axisColor)
        }

        let cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.automaticallyAdjustsZRange = true
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: Float(-0.22), y: Float(0.15), z: Float(0.65))
        cameraNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(5), y: GLKMathDegreesToRadians(-18), z: 0.0)
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
        
        startChartAnimationTimer()
    }
    
    func addSecurityHeader(_ node: SCNNode) {
        let y: CGFloat = 370.0
        addText(node, 0.0, y+20.0, ideaModel?.securityTicker, .largeTitle)
        addText(node, 0.0, y, ideaModel?.securityName, .body)
    }
    
    func addAlpha(_ node: SCNNode) {
        let y: CGFloat = 286.0
        addText(node, 0.0, y+34.0, "Alpha", .body)
        addText(node, 0.0, y, ideaModelLogicDecorator?.getDisplayValueForAlpha(), .title1)
    }
    
    func addText(_ node: SCNNode, _ x: CGFloat, _ y: CGFloat, _ string: String?, _ textStyle: UIFont.TextStyle) {
        guard let string = string else {
            return
        }

        let font = UIFont.preferredFont(forTextStyle: textStyle)
        let textWidth = string.size(withAttributes: [NSAttributedString.Key.font: font]).width
        
        let text = SCNText(string: string, extrusionDepth: 0)
        text.font = font
        text.firstMaterial?.diffuse.contents = UIColor.white
        text.flatness = 0.01
        
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3Make(Float(x-0.5*textWidth), Float(y), 0.0)
        node.addChildNode(textNode)
    }
    
    func addAxis(_ node: SCNNode, _ color: UIColor) {
        let width: CGFloat = view.bounds.width
        addLine(node, 0.0, 0.0, width, 3.0, 3.0, UIColor.gray)
    }
    
    func addGrid(_ node: SCNNode, _ color: UIColor) {
        let width: CGFloat = view.bounds.width
        let dy: CGFloat = 36.0
        var y: CGFloat = dy
        
        for _ in 1...6 {
            addLine(node, 0.0, y, width, 1.5, 1.5, UIColor.gray)
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
    
    func addLineGraph(_ node: SCNNode, isBenchmark: Bool, _ color: UIColor) -> SCNNode {
        let width: CGFloat = view.bounds.width
        let graphPath = UIBezierPath()
        var index = 0
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        let lineWidth: CGFloat = 5.0
        let benchmarkItems = graphViewModel?.graphModel?.benchmark ?? []
        let tickerItems = graphViewModel?.graphModel?.ticker ?? []
        let (minX, minY, scaleX, scaleY) = ChartNativeView.getScaleFactor(benchmarkItems, tickerItems, width, graphHeight)
        let graphItems = isBenchmark ? benchmarkItems : tickerItems
        let items = getItems(graphItems)

        for item in items {
            let vx = CGFloat(item.x)
            let vy = CGFloat(item.y)
            x = (vx-minX) * scaleX
            y = (vy-minY) * scaleY + (0.25*graphHeight)
            
            if index == 0 {
                graphPath.move(to: CGPoint(x: x, y: y))
            }
            else {
                graphPath.addLine(to: CGPoint(x: x, y: y))
            }
            index += 1
        }

        for item in items.reversed() {
            let vx = CGFloat(item.x)
            let vy = CGFloat(item.y)
            x = (vx-minX) * scaleX
            y = (vy-minY) * scaleY + (0.25*graphHeight)
            
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
        return shapeNode
    }
    
    func getItems(_ items: [TickModel]) -> [TickModel] {
        var list = [TickModel]()
        var index = 0
        let maxIndex = Int(ceil(chartFraction * CGFloat(items.count)))
        
        for item in items {
            if index <= maxIndex {
                list.append(item)
            }
            index += 1
        }
        return list
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
    
    func refreshChart() {
        if let node = sceneNode {
            benchmarkNode?.removeFromParentNode()
            tickerNode?.removeFromParentNode()
            
            benchmarkNode = addLineGraph(node, isBenchmark: true, benchmarkColor)
            tickerNode = addLineGraph(node, isBenchmark: false, tickerColor)
        }
    }

    func startChartAnimationTimer() {
        chartAnimationTimer?.invalidate()
        
        chartFraction = 0.0
        chartAnimationTimer = Timer.scheduledTimer(timeInterval: (1.0/60.0), target: self, selector: #selector(stepChartAnimationTimer), userInfo: nil, repeats: true)
    }
    
    @objc func stepChartAnimationTimer() {
        chartFraction = chartFraction + 0.015
        refreshChart()
        if chartFraction >= 1.0 {
            chartAnimationTimer?.invalidate()
        }
    }
}

struct Chart3DViewControllerWrapper: UIViewControllerRepresentable {

    typealias UIViewControllerType = Chart3DViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<Chart3DViewControllerWrapper>) -> Chart3DViewControllerWrapper.UIViewControllerType {
        return Chart3DViewController()
    }

    func updateUIViewController(_ uiViewController: Chart3DViewControllerWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<Chart3DViewControllerWrapper>) {
    }
}

class Chart3DViewController: UIViewController {

    var sceneView = SCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sceneView)
        
        let scene = SCNScene()
        let node = SCNNode()
        scene.rootNode.addChildNode(node)
        
        addChartBar(node, "Dmitri", 3.7,  -1.875, .blue)
        addChartBar(node, "Ajay", 3.5, -0.625, .green)
        addChartBar(node, "Piyush", 2.9, 0.625, .orange)
        addChartBar(node, "Mark", 2.7, 1.875, .red)
        
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.automaticallyAdjustsZRange = true
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: Float(0.16), y: Float(0.45), z: Float(0.36))
        cameraNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-45), y: GLKMathDegreesToRadians(25), z: 0.0)
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
    
    func addChartBar(_ node: SCNNode, _ name: String, _ value: CGFloat, _ offset: CGFloat, _ color: UIColor) {
        let width: CGFloat = 0.04
        let height: CGFloat = 0.04
        let length: CGFloat = 0.04
        let barScale: CGFloat = 1.8
        let barHeight = barScale*value*height
        
        let bar = SCNBox(width: width, height: barHeight, length: length, chamferRadius: 0.1*width)
        bar.firstMaterial?.lightingModel = .physicallyBased
        bar.firstMaterial?.diffuse.contents = color
        bar.firstMaterial?.metalness.contents = 0.8
        bar.firstMaterial?.roughness.contents = 0.2
        let barNode = SCNNode(geometry: bar)
        barNode.position = SCNVector3(x: Float(offset*width), y: Float(0.5*barHeight), z: 0.0)
        node.addChildNode(barNode)
        
        let title = "\(value)"
        let textHeight = 0.5*width
        let textScale: Float = Float(textHeight) / 10.0
        let barText = SCNText(string: title, extrusionDepth: 0)
        barText.font = UIFont(name: "Arial", size: 10)
        barText.firstMaterial?.diffuse.contents = UIColor.white
        barText.flatness = 0.01
        let barTextNode = SCNNode(geometry: barText)
        barTextNode.position = SCNVector3Make(Float((offset+0.35)*width), 0.5*0.03, Float(0.5*width+0.001))
        barTextNode.scale = SCNVector3Make(textScale, textScale, textScale)
        barTextNode.rotation = SCNVector4(x: 0, y: 0, z: 1, w: GLKMathDegreesToRadians(90.0))
        node.addChildNode(barTextNode)
        
        let labelLength = 2.0*length
        let label = SCNBox(width: width, height: 0.0, length: 2.0*length, chamferRadius: 0.0)
        label.firstMaterial?.lightingModel = .physicallyBased
        label.firstMaterial?.diffuse.contents = color
        label.firstMaterial?.metalness.contents = 0.8
        label.firstMaterial?.roughness.contents = 0.2
        let labelNode = SCNNode(geometry: label)
        labelNode.position = SCNVector3(x: Float(offset*width), y: Float(0.0), z: Float(0.5*length+0.5*labelLength+0.01))
        node.addChildNode(labelNode)
        
        let labelHeight = 0.5*width
        let labelScale: Float = Float(labelHeight) / 10.0
        let labelText = SCNText(string: name, extrusionDepth: 0)
        labelText.font = UIFont(name: "Arial", size: 10)
        labelText.firstMaterial?.diffuse.contents = UIColor.white
        labelText.flatness = 0.01
        let labelTextNode = SCNNode(geometry: labelText)
        labelTextNode.position = SCNVector3Make(Float((offset+0.35)*width), 0.001, 0.1)
        labelTextNode.scale = SCNVector3Make(labelScale, labelScale, labelScale)
        labelTextNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-90), y: GLKMathDegreesToRadians(90), z: 0)
        node.addChildNode(labelTextNode)
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
}
