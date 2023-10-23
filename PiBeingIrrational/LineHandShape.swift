//
//  LineHandShape.swift
//  PiBeingIrrational
//
//  Created by Amit Samant on 24/10/23.
//

import SwiftUI

struct LineHandShape: Shape {
    var angle: Double
    var rate: Double
    var endpoinUpdated:(CGPoint) -> Void
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(angle, rate)
        }
        set {
            angle = newValue.first
            rate = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let startPoint = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: startPoint)
            let midPoint = getMidPoint(centre: startPoint, r: rect.width/4, angle: angle)
            path.addLine(to: midPoint)
            let endPoint = getMidPoint(centre: midPoint, r: rect.width/4, angle: angle*rate)
            path.addLine(to: endPoint)
            endpoinUpdated(endPoint)
        }
    }
    
    func getMidPoint(centre: CGPoint, r: Double, angle: Double) -> CGPoint {
        let degrees = angle * (Double.pi/180)
        let px = centre.x + r * cos(degrees)
        let py = centre.y + r * sin(degrees)
        return CGPoint(x: px, y: py)
    }
}
