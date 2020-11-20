//
//  SongPlayerViewController.swift
//  ef.pulsar-palace
//
//  Created by Gabriel Walsh on 8/29/20.
//  Copyright © 2020 Gabriel Walsh. All rights reserved.
//

import UIKit
import AVFoundation

class SongPlayerViewController: UIViewController {
    
    var songPlayer = AVAudioPlayer()
    var isPaused: Bool = false
    
    func prepareSong(){
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "example", ofType: "mp3")!))
            
            songPlayer.prepareToPlay()
            let songSession = AVAudioSession.sharedInstance()
            
            do{
                try songSession.setCategory(AVAudioSession.Category.playback)
                
            } catch let sessionError {
                print (sessionError)
                let error: Error = PulsarError.musicPlayerSessionError
                print(error.localizedDescription)
            }
        } catch let playerError {
            print(playerError)
            let error: Error = PulsarError.musicPlayerPlaybackError
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSong()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center = view.center
        button.backgroundColor = .systemPink
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonClicked() {
        print("Button Clicked")
        playSong()
    }
    
    func playSong(){
        songPlayer.play()
    }
    
    func pauseSong(){
        if songPlayer.isPlaying{
            songPlayer.pause()
            isPaused = true
        }else{
            isPaused = false
        }
    }
    
    func restartSong(){
        if songPlayer.isPlaying || isPaused {
            songPlayer.stop()
            songPlayer.currentTime = 0
            songPlayer.play()
        }else{
            songPlayer.play()
        }
    }
    
}
