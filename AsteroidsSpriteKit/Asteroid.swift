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
    var size: Float!
    var numPoints: Int!
    var sharpness: Float!
    var number: Int!
    init(size: Float, numPoints: Int, sharpness: Float, addTo parent: SKNode?) {
        self.number=1
        self.size = size
        self.numPoints = numPoints
        self.sharpness = sharpness
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

        shapeNode.physicsBody = SKPhysicsBody(polygonFrom: path)
        shapeNode.physicsBody?.affectedByGravity=false
        shapeNode.physicsBody?.allowsRotation=true
        shapeNode.physicsBody?.isDynamic=true
        shapeNode.physicsBody?.angularDamping=0
        shapeNode.physicsBody?.linearDamping=0
        shapeNode.physicsBody?.restitution=0.4
        shapeNode.physicsBody?.contactTestBitMask = contactAsteroid
        shapeNode.physicsBody?.categoryBitMask = categoryAsteroid
        shapeNode.physicsBody?.collisionBitMask = collisionAsteroid
        shapeNode.physicsBody?.velocity = CGVector(dx: CGFloat(randNewVel()), dy: CGFloat(randNewVel()))
        
        if parent != nil {
            parent!.addChild(shapeNode)
        }
    }
    
    func addTo(_ parent: SKNode) {
        parent.addChild(shapeNode)
    }
    
    func canSplit() -> Bool {
        return size > 10
    }
    
    func randNewVel() -> Float {
        return Float.random(in: -20...20)
    }
    
//    func split(addTo: SKScene) -> [Asteroid] {
//        let asteroid1: Asteroid = Asteroid(size: size/2, numPoints: numPoints, sharpness: sharpness/2, addTo: addTo)
//        let asteroid2: Asteroid = Asteroid(size: size/2, numPoints: numPoints, sharpness: sharpness/2, addTo: addTo)
//        
//        asteroid1.shapeNode.position = CGPoint(x: shapeNode.position.x, y: shapeNode.position.y)
//        asteroid2.shapeNode.position = CGPoint(x: shapeNode.position.x, y: shapeNode.position.y)
//        asteroid1.shapeNode.physicsBody?.velocity = CGVector(dx: CGFloat(randNewVel()), dy: CGFloat(randNewVel()))
//        asteroid2.shapeNode.physicsBody?.velocity = CGVector(dx: CGFloat(randNewVel()), dy: CGFloat(randNewVel()))
//        
//        asteroid1.number=number+1
//        asteroid2.number=number+1
//        
//        return [asteroid1, asteroid2]
//    }
    
    func update(){
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
