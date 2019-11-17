//
//  GraphView.swift
//  KotlinIOS
//
//  Created by Lee, Mark on 11/11/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI

struct IdeaData: Codable {
    var id: Int
    var intervalOption: String
    var ideaAge: Int
    var absolutePerformance: [CGFloat]
    var benchmarkPerformance: [CGFloat]
    var alpha: [CGFloat]
    var createdDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case intervalOption = "IntervalOption"
        case ideaAge = "IdeaAge"
        case absolutePerformance = "AbsolutePerformance"
        case benchmarkPerformance = "BenchmarkPerformance"
        case alpha = "Alpha"
        case createdDate = "CreatedDate"
    }
}

struct GraphView: View {
    
    //var ideaData: IdeaData?
    
    var body: some View {
        ZStack {
            Path { path in
                let width: CGFloat = 380
                let height: CGFloat = 250
                
                path.move(to: CGPoint(x: Double(20.0), y: Double(0.0)))
                path.addLine(to: CGPoint(x: Double(20.0+width), y: Double(0.0)))
                path.addLine(to: CGPoint(x: Double(20.0+width), y: Double(height)))
                path.addLine(to: CGPoint(x: Double(20.0), y: Double(height)))
            }
            .fill(Color(red: 47.0/255.0, green: 55.0/255.0, blue: 69.0/255.0))
             
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
            
            Path { path in
                let width: CGFloat = 380
                let height: CGFloat = 250
                
                let data = getBenchmarkData()
                var index = 0
                var x: CGFloat = 20.0
                let scaleX: CGFloat = -0.4
                let dx = width / CGFloat(data.count)
                
                for value in data {
                    let y = 0.5*height + scaleX*value*height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: Double(x), y: Double(y)))
                    }
                    else {
                        path.addLine(to: CGPoint(x: Double(x), y: Double(y)))
                    }
                    x += dx
                    index += 1
                }
                
                path.addLine(to: CGPoint(x: Double(20.0+width), y: Double(height)))
                path.addLine(to: CGPoint(x: Double(20.0), y: Double(height)))
            }
            .stroke(lineWidth: CGFloat(2.0))
            .fill(Color(red: 165.0/255.0, green: 170.0/255.0, blue: 180.0/255.0))
            
            Path { path in
                let width: CGFloat = 380
                let height: CGFloat = 250
                
                let data = getIdeaData()
                var index = 0
                var x: CGFloat = 20.0
                let scaleX: CGFloat = -0.4
                let dx = width / CGFloat(data.count)
                
                for value in data {
                    let y = 0.5*height + scaleX*value*height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: Double(x), y: Double(y)))
                    }
                    else {
                        path.addLine(to: CGPoint(x: Double(x), y: Double(y)))
                    }
                    x += dx
                    index += 1
                }
            }
            .stroke(lineWidth: CGFloat(2.0))
            .fill(Color(red: 88.0/255.0, green: 154.0/255.0, blue: 234.0/255.0))
        }
    }
    
    func getIdeaData() -> [CGFloat] {
        let ideaData = parseJSONData()
        return ideaData?.absolutePerformance ?? []
    }
    
    func getBenchmarkData() -> [CGFloat] {
        let ideaData = parseJSONData()
        return ideaData?.benchmarkPerformance ?? []
    }
    
    func parseJSONData() -> IdeaData? {
        if let data = getJSONData() {
            if let result = try? JSONDecoder().decode([IdeaData].self, from: data) {
                return result.first
            }
        }
        return nil
    }
    
    func getJSONData() -> Data? {
        if let url = Bundle.main.url(forResource: "IdeaData", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
}

struct GraphView_Preview: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
