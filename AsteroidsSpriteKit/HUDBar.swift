//
//  HUDBar.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/4/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import SpriteKit

class HUDBar {
    
    var shapeNode: SKShapeNode!
    
    init(x: Float, y: Float, width w: Float, height h: Float, red: Float, green: Float, blue: Float, addTo parent: SKNode) {
        shapeNode = SKShapeNode(rect: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(w), height: CGFloat(h)))
        shapeNode.strokeColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        shapeNode.fillColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        parent.addChild(shapeNode)
    }
    
    func setAmount(perc: Float) {
        shapeNode.xScale = CGFloat(perc)
    }
    
}
