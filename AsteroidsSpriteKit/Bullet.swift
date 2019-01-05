//
//  Bullet.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/3/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet {
    var shapeNode: SKShapeNode!
    var life: Int = 0
    
    init(length: Float, height: Float, addTo: SKNode) {
        let points: [CGPoint] = [
            CGPoint(x: 0, y: 0),
            CGPoint(x: CGFloat(height), y: 0),
            CGPoint(x: CGFloat(height), y: CGFloat(length)),
            CGPoint(x: 0, y: CGFloat(length)),
            CGPoint(x: 0, y: 0)
        ]
        shapeNode = SKShapeNode(points: UnsafeMutablePointer(mutating: points), count: points.count)
        shapeNode.strokeColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let path=CGMutablePath()
        path.addLines(between: points)
        path.closeSubpath()
        
        shapeNode.physicsBody=SKPhysicsBody(polygonFrom: path)
        shapeNode.physicsBody?.affectedByGravity=false
        shapeNode.physicsBody?.allowsRotation=false
        shapeNode.physicsBody?.isDynamic=true
        shapeNode.physicsBody?.angularDamping=0
        shapeNode.physicsBody?.linearDamping=0
        shapeNode.physicsBody?.restitution=0
        shapeNode.physicsBody?.contactTestBitMask = contactBullet
        shapeNode.physicsBody?.categoryBitMask = categoryBullet
        shapeNode.physicsBody?.collisionBitMask = collisionBullet
        shapeNode.physicsBody?.mass = 0.005
        addTo.addChild(shapeNode)
        life = 50
    }
    
    func dieSoon() {
        life = 0
    }
    
    func update() {
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
        
        life -= 1
//        print(life)
    }
    
    func shouldDie() -> Bool {
        return life < 0
    }
    
}
