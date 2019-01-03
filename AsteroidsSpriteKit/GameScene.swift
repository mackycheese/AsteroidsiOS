//
//  GameScene.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/3/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    var motionManager: CMMotionManager!
    
    override func sceneDidLoad() {
        physicsWorld.gravity=CGVector(dx: 0, dy: 0)
        physicsWorld.speed=5
        
//        for _ in 0..<20{
//            let a: Asteroid=Asteroid(size:30,numPoints:10,sharpness:20,addTo:self)
//            a.shapeNode.position=CGPoint(x: CGFloat.random(in: 0..<UIScreen.main.bounds.width), y: CGFloat.random(in:0..<UIScreen.main.bounds.height))
//        }
        for _ in 0..<100{
            let a: Asteroid=Asteroid(size:10,numPoints:3,sharpness:1,addTo:self)
            a.shapeNode.position=CGPoint(x: CGFloat.random(in: 0..<UIScreen.main.bounds.width), y: CGFloat.random(in:0..<UIScreen.main.bounds.height))
        }

        let border = SKPhysicsBody(edgeLoopFrom: frame)
        border.friction=0
        self.physicsBody=border
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
    }
    
    override func didMove(to view: SKView) {
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        
    }
    
    var pastTime: TimeInterval! = nil
    
    override func update(_ currentTime: TimeInterval) {
        var diffTime: TimeInterval! = 0
        if pastTime == nil {
            pastTime = currentTime
            diffTime = 0
        } else {
            diffTime = currentTime - pastTime
        }
        let data=motionManager.gyroData
        if data != nil {
            physicsWorld.gravity.dx+=CGFloat((data?.rotationRate.y)! * diffTime)
            physicsWorld.gravity.dy-=CGFloat((data?.rotationRate.x)! * diffTime)
//            physicsWorld.gravity=physicsWorld.gravity+CGVector(dx: (data?.rotationRate.y)!, dy: -(data?.rotationRate.x)!)
        }
        
        pastTime = currentTime
    }
    
}
