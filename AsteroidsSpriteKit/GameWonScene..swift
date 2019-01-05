//
//  GameWonScene.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/4/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class GameWonScene: SKScene {
    
    var tap2play: SKLabelNode!
    var hapticHeavy: UIImpactFeedbackGenerator!
    
    override func sceneDidLoad() {
        hapticHeavy = UIImpactFeedbackGenerator(style: .heavy)
        
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height
        
        let titleTxt: SKLabelNode = SKLabelNode(text: "You won!")
        titleTxt.fontSize=70
        titleTxt.horizontalAlignmentMode = .center
        titleTxt.verticalAlignmentMode = .center
        titleTxt.position = CGPoint(x: width/2, y: height/2)
        
        tap2play = SKLabelNode(text: "Tap to play again")
        tap2play.color=UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        tap2play.fontSize=30
        tap2play.horizontalAlignmentMode = .center
        tap2play.verticalAlignmentMode = .center
        tap2play.position=CGPoint(x:width/2,y:height/2-50)
        
        addChild(titleTxt)
        addChild(tap2play)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 1)
        let nextScene = GameScene(size: scene!.size)
        nextScene.scaleMode = .aspectFill
        scene?.view?.presentScene(nextScene, transition: transition)
        hapticHeavy.impactOccurred()
    }
    
    override func update(_ currentTime: TimeInterval) {
        tap2play.setScale(1+0.05*cos(CGFloat(5*currentTime)))
    }
    
}
