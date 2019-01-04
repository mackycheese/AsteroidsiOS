//
//  BitMasks.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/3/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation

let contactBullet    : UInt32 = UInt32("100", radix: 2)!
let categoryBullet   : UInt32 = UInt32("001", radix: 2)!
let collisionBullet  : UInt32 = UInt32("100", radix: 2)!

let contactPlayer    : UInt32 = UInt32("100", radix: 2)!
let categoryPlayer   : UInt32 = UInt32("010", radix: 2)!
let collisionPlayer  : UInt32 = UInt32("100", radix: 2)!

let contactAsteroid  : UInt32 = UInt32("001", radix: 2)!
let categoryAsteroid : UInt32 = UInt32("100", radix: 2)!
let collisionAsteroid: UInt32 = UInt32("011", radix: 2)!
