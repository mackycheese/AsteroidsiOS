//
//  Sounds.swift
//  AsteroidsSpriteKit
//
//  Created by Jack Armstrong on 1/4/19.
//  Copyright © 2019 Jack Armstrong. All rights reserved.
//

import Foundation
import AVFoundation

var sounds: [AVAudioPlayer] = []

func getData(soundName: String) -> Data {
    return try! Data(contentsOf: Bundle.main.url(forResource: "asteroids-sounds/"+soundName, withExtension: "wav")!)
}

func playSound(withData data: Data) {
//    DispatchQueue.global(qos: .background).async {
        let sound = try! AVAudioPlayer(data: data)
        sound.prepareToPlay()
        sound.play()
        sounds.append(sound)
//    }
}

func playSound(withData data: Data, doRepeat: Bool, withSpeed speed: Float, volume: Float) {
//    DispatchQueue.global(qos: .background).async {
        let sound = try! AVAudioPlayer(data: data)
        if doRepeat {
            sound.numberOfLoops = -1
        }
        sound.enableRate = true
        sound.rate = speed
        sound.volume = volume
        sound.prepareToPlay()
        sound.play()
        sounds.append(sound)
//    }
}

func playSound(withData data: Data, volume: Float) {
//    DispatchQueue.global(qos: .background).async {
        let sound = try! AVAudioPlayer(data: data)
        sound.volume = volume
        sound.prepareToPlay()
        sound.play()
        sounds.append(sound)
//    }
}

func remOverSounds() {
    var new: [AVAudioPlayer] = []
    for i in 0..<sounds.count {
        if sounds[i].isPlaying {
            new.append(sounds[i])
        }
    }
    sounds=new
}
