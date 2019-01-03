//
//  Asteroid.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/3/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

class Asteroid {
    
    var shapeNode: SKShapeNode!
    
    init(size: Float, numPoints: Int, sharpness: Float, addTo: SKScene) {
        var points: [CGPoint] = Array(repeating: CGPoint(x: 0, y: 0), count: numPoints+1)
        for i in 0..<numPoints {
            let angle:CGFloat=(CGFloat(i)/CGFloat(numPoints))*2*CGFloat.pi
            let r:CGFloat=CGFloat( Float.random(in:  size..<size+sharpness  )  )
            points[i]=CGPoint(x: CGFloat(cos(angle)*r), y: CGFloat(sin(angle)*r))
        }
        points[numPoints]=CGPoint(x: points[0].x, y: points[0].y)
        shapeNode=SKShapeNode(points: UnsafeMutablePointer(mutating: points), count: points.count)
        shapeNode.strokeColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let path = CGMutablePath()
        path.addLines(between: points)
        path.closeSubpath()
//        path.move(to: points[0])
//        for i in 1..<points.count{
////            path.move(to: points[i])
//            path.addLine(to: points[i])
//        }

        shapeNode.physicsBody = SKPhysicsBody(polygonFrom: path)
//        shapeNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        shapeNode.physicsBody?.affectedByGravity=true
        shapeNode.physicsBody?.allowsRotation=true
        shapeNode.physicsBody?.isDynamic=true
        shapeNode.physicsBody?.angularDamping=0
        shapeNode.physicsBody?.linearDamping=0
        shapeNode.physicsBody?.restitution=1
        shapeNode.physicsBody?.charge=CGFloat.random(in: -1000..<1000)
        addTo.addChild(shapeNode)
    }
    
    func setPosition(_ x: Float, _ y: Float) {
        shapeNode.position=CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
    
}
