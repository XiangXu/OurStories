//
//  MusicHelper.swift
//  OurStories
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//

import AVFoundation

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?

    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }

    func playBackgroundMusic() {
        if let audioPlayer = audioPlayer {
            audioPlayer.play()
            return
        }

        if let backgroundMusic = Bundle.main.url(forResource: "jay", withExtension: "mp3"){
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }

    func pauseBackgroundMusic() {
        audioPlayer?.pause()
    }
}
