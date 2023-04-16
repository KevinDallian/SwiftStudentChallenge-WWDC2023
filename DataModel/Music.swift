//
//  File.swift
//  
//
//  Created by Kevin Dallian on 16/04/23.
//

import Foundation
import AVFoundation

final class MusicPlayer {
    static let sharedMusic = MusicPlayer()
    
    var player : AVAudioPlayer?
    
    func playMusic(){
        guard let url = Bundle.main.url(forResource: "Girasol - Quincas Moreira", withExtension: "mp3") else{
            print("Resource not found")
            return
        }
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.setVolume(0.4, fadeDuration: 0)
            player?.numberOfLoops = -1
            player?.play()
        } catch{
            print("Fail to play music", error)
        }
    }
}

