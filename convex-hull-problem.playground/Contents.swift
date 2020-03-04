import UIKit

let points: [CGPoint] = [
    CGPoint(x: 0, y: 15),
    CGPoint(x: 4, y: 10),
    CGPoint(x: 32, y: 11),
    CGPoint(x: -3, y: -1),
    CGPoint(x: 6, y: 5),

]

func getConvexHull(points: [CGPoint]) -> [CGPoint] {
    guard points.count > 0 else { return [] }
    let maxX = points.map { $0.x }.max()!
    let minX = points.map { $0.x }.min()!
    let maxY = points.map { $0.y }.max()!
    let minY = points.map { $0.y }.min()!
        
    var hullPoints = [
        CGPoint(x: minX, y: minY),
        CGPoint(x: minX, y: maxY),
        CGPoint(x: maxX, y: maxY),
        CGPoint(x: maxX, y: minY)
    ]
    
    for i in 0..<hullPoints.count {
        let firstPoint = hullPoints[i]
        let secondPoint = i+1 < hullPoints.count ? hullPoints[i+1] : hullPoints[0]
        
        
    }
    return []
}

