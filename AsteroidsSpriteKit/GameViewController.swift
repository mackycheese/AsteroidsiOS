//
//  GameViewController.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/2/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as? SKView
        
        let scene: SKScene = GameScene(size: skView!.bounds.size)
//        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        skView!.showsFPS=true
        skView!.showsNodeCount=true
        skView!.showsDrawCount=true
        skView!.showsQuadCount=true
        skView!.showsPhysics=true
        
        skView!.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
