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
import AVFoundation

class GameViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let skView = view as? SKView
        
        let scene: SKScene = GameStartScene(size: skView!.bounds.size)
//        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
//        skView!.showsFPS=true
//        skView!.showsNodeCount=true
//        skView!.showsDrawCount=true
//        skView!.showsQuadCount=true
//        skView!.showsPhysics=true
        try! AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try! AVAudioSession.sharedInstance().setActive(true)
        
        soundBeat1 = getData(soundName: "beat1")
        soundBeat2 = getData(soundName: "beat2")
        
        let _: Timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onBeat), userInfo: nil, repeats: true)

        
        skView!.presentScene(scene)
    }
    
    var soundBeat1: Data!
    var soundBeat2: Data!
    var curBeat: Int = 0
    
    @objc func onBeat() {
        curBeat += 1
        
        if curBeat % 2 == 0 {
            playSound(withData: soundBeat1, volume: 10)
        } else {
            playSound(withData: soundBeat2, volume: 10)
        }
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
