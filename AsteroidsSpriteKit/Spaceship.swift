//
//  Spaceship.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/3/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

class Spaceship {
    
    var shapeNode: SKShapeNode!
    
    init(size: Float, addTo: SKNode) {
        let cg_size: CGFloat = CGFloat(size)
        let points: [CGPoint] = [
            CGPoint(x: -cg_size/2, y: -cg_size),
            CGPoint(x: cg_size/2, y: -cg_size),
            CGPoint(x: 0, y: cg_size),
            CGPoint(x: -cg_size/2, y: -cg_size)
        ]
        
        shapeNode=SKShapeNode(points:UnsafeMutablePointer(mutating: points),count:points.count)
        shapeNode.strokeColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let path=CGMutablePath()
        path.addLines(between: points)
        path.closeSubpath()
        
        shapeNode.physicsBody=SKPhysicsBody(polygonFrom: path)
        shapeNode.physicsBody?.affectedByGravity=true
        shapeNode.physicsBody?.allowsRotation=false
        shapeNode.physicsBody?.isDynamic=true
        shapeNode.physicsBody?.angularDamping=0
        shapeNode.physicsBody?.linearDamping=0
        shapeNode.physicsBody?.restitution=0.2
        shapeNode.physicsBody?.contactTestBitMask = contactPlayer
        shapeNode.physicsBody?.categoryBitMask = categoryPlayer
        shapeNode.physicsBody?.collisionBitMask = collisionPlayer
        addTo.addChild(shapeNode)
    }
    
    func getAngle() -> Float {
        let dx: CGFloat! = shapeNode.physicsBody?.velocity.dx
        let dy: CGFloat! = shapeNode.physicsBody?.velocity.dy
        return atan2f(Float(dy!), Float(dx!))-Float.pi/2
    }
    
    func update() {
        shapeNode.zRotation=CGFloat(getAngle())
        
        let cgWidth=UIScreen.main.bounds.width
        let cgHeight=UIScreen.main.bounds.height
        
        if shapeNode.position.x<0 {
            shapeNode.position.x=cgWidth
        }
        if shapeNode.position.x>cgWidth{
            shapeNode.position.x=0
        }
        if shapeNode.position.y < 0 {
            shapeNode.position.y=cgHeight
        }
        if shapeNode.position.y > cgHeight {
            shapeNode.position.y = 0
        }
    }
    
}
