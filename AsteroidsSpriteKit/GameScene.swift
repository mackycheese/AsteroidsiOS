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
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var motionManager: CMMotionManager!
    
    var player: Spaceship!
    
    var asteroids: [Asteroid] = []
    var bullets: [Bullet] = []
    
    var hapticHeavy: UIImpactFeedbackGenerator!
    var hapticMedium: UIImpactFeedbackGenerator!
    var hapticLight: UIImpactFeedbackGenerator!
    
    let asteroidSize: Float = 50
    let asteroidSharpness: Float = 20
    
    override func sceneDidLoad() {
        physicsWorld.gravity=CGVector(dx: 0, dy: 0)
        physicsWorld.speed=2
        
//        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

        for _ in 0..<10{
            let a: Asteroid=Asteroid(size:asteroidSize,numPoints:9,sharpness:asteroidSharpness,addTo:self)
            a.shapeNode.position=CGPoint(x: CGFloat.random(in: 0..<UIScreen.main.bounds.width), y: CGFloat.random(in:0..<UIScreen.main.bounds.height))
            asteroids.append(a)
        }
        
        hapticHeavy = UIImpactFeedbackGenerator(style: .heavy)
        hapticMedium = UIImpactFeedbackGenerator(style: .medium)
        hapticLight = UIImpactFeedbackGenerator(style: .light)

//        let border = SKPhysicsBody(edgeLoopFrom: frame)
//        border.friction=0
//        self.physicsBody=border
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        
        player = Spaceship(size: 20, addTo: self)
        player.shapeNode.position=CGPoint(x: 100, y: 100)
        
        physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
    }
    
    override func didChangeSize(_ oldSize: CGSize) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touches began")
        let bullet: Bullet = Bullet(length: 10, height: 2, addTo: self)
        bullet.shapeNode.position = player.shapeNode.position
        
        var velX: Float = Float((player.shapeNode.physicsBody?.velocity.dx)!)
        var velY: Float = Float((player.shapeNode.physicsBody?.velocity.dy)!)
        let len: Float = sqrt(velX*velX+velY*velY)
        velX/=len
        velY/=len
        bullet.shapeNode.physicsBody?.velocity=CGVector(dx: CGFloat(velX*80), dy: CGFloat(velY*80))
        bullet.shapeNode.zRotation = CGFloat(player.getAngle())
        bullets.append(bullet)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesBegan(touches, with: event)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA: SKPhysicsBody = contact.bodyA
        let bodyB: SKPhysicsBody = contact.bodyB
        let categoryA: UInt32 = bodyA.categoryBitMask
        let categoryB: UInt32 = bodyB.categoryBitMask
        
        
        var bullet: Bullet! = nil
        
        if categoryA == categoryBullet {
            bullet = findBullet(withBody: bodyA)
        }
        
        if categoryB == categoryBullet {
            bullet = findBullet(withBody: bodyB)
        }
        
        
        if categoryA == categoryBullet || categoryB == categoryBullet {
            if bullet != nil {
                bullet.dieSoon()
            }
        }
        if categoryA == categoryAsteroid || categoryB == categoryAsteroid {
            var asteroid: Asteroid! = nil
            
            if categoryA == categoryAsteroid {
                asteroid = findAsteroid(withBody: bodyA)
            }
            
            if categoryB == categoryAsteroid {
                asteroid = findAsteroid(withBody: bodyB)
            }
            
            if asteroid != nil && bullet != nil {
                if asteroid.canSplit() {
                    for _ in 0..<2 {
                        let new=Asteroid(size: asteroid.size/2,numPoints:asteroid.numPoints,sharpness:asteroid.sharpness/2,addTo:nil)
                        new.shapeNode.position=asteroid.shapeNode.position
                        new.addTo(self)
                        asteroids.append(new)
                    }
//                    let new=asteroid.split(addTo: self)
//                    new[0].shapeNode.position=asteroid.shapeNode.position
//                    new[1].shapeNode.position=asteroid.shapeNode.position
//                    asteroids.append(new[0])
//                    asteroids.append(new[1])
//                    let new0 = Asteroid(size: asteroid.size/2, numPoints: asteroid.numPoints, sharpness: asteroid.sharpness/2, addTo: self)
//                    new0.shapeNode.position = CGPoint(x: 100, y: 100)
//                    asteroids.append(new0)
//                    let new0: Asteroid=Asteroid(size:30,numPoints:9,sharpness:20,addTo:nil)
//                    new0.shapeNode.position=CGPoint(x: CGFloat.random(in: 0..<UIScreen.main.bounds.width), y: CGFloat.random(in:0..<UIScreen.main.bounds.height))
//                    new0.addTo(self)
//                    asteroids.append(new0)
//
//                    let new1: Asteroid=Asteroid(size:30,numPoints:9,sharpness:20,addTo:nil)
//                    new1.shapeNode.position=CGPoint(x: CGFloat.random(in: 0..<UIScreen.main.bounds.width), y: CGFloat.random(in:0..<UIScreen.main.bounds.height))
//                    new1.addTo(self)
//                    asteroids.append(new1)
                }
                asteroid.shapeNode.removeFromParent()
                asteroids=asteroids.filter { $0 !== asteroid! }
                if asteroid.size == asteroidSize {
                    hapticHeavy.impactOccurred()
                }
                if asteroid.size == asteroidSize / 2 {
                    hapticMedium.impactOccurred()
                }
                if asteroid.size == asteroidSize / 4 {
                    hapticLight.impactOccurred()
                }
            }
        }
    }
    
    func findBullet(withBody body: SKPhysicsBody) -> Bullet! {
        for i in 0..<bullets.count {
            if bullets[i].shapeNode.physicsBody == body {
                return bullets[i]
            }
        }
        return nil
    }
    
    func findAsteroid(withBody body: SKPhysicsBody) -> Asteroid! {
        for i in 0..<asteroids.count {
            if asteroids[i].shapeNode.physicsBody == body {
                return asteroids[i]
            }
        }
        return nil
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
//        let data=motionManager.gyroData
//        if data != nil {
//            physicsWorld.gravity.dx=5*CGFloat((data?.rotationRate.y)! * diffTime)
//            physicsWorld.gravity.dy = -5*CGFloat((data?.rotationRate.x)! * diffTime)
////            physicsWorld.gravity=physicsWorld.gravity+CGVector(dx: (data?.rotationRate.y)!, dy: -(data?.rotationRate.x)!)
//        }

        let data=motionManager.accelerometerData
        if data != nil {
            physicsWorld.gravity.dx=20*CGFloat((data?.acceleration.x)!*diffTime)
            physicsWorld.gravity.dy=20*CGFloat((data?.acceleration.y)!*diffTime)
        }
        
        player.update()
        for i in 0..<asteroids.count {
            asteroids[i].update()
        }
        var newBullets: [Bullet] = []
        for i in 0..<bullets.count {
            bullets[i].update()
            if bullets[i].shouldDie() {
                bullets[i].shapeNode.removeFromParent()
            } else {
                newBullets.append(bullets[i])
            }
        }
        bullets = newBullets
        
        pastTime = currentTime
    }
    
}
