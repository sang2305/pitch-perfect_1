//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Praveen Ramanathan on 5/15/15.
//  Copyright (c) 2015 Sangeetha. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
     var audioPlayer2:AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer2 = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer.enableRate = true
        
        audioEngine=AVAudioEngine()
        audioFile=AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    
    }
    
    //To reset all audioPlayers
    func resetPlayers()
    {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer2.stop()
    }
    
    //Method for fast and slow audio
    func playAudioWithVariableRate(rate: Float){
        resetPlayers()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    

    @IBAction func slowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    
    @IBAction func fastAudio(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    //Method for Chipmunk and Darthvader effects
    func playAudioWithVariablePitch(pitch: Float){
        
        resetPlayers()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode , format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    //Add echo to audio
    @IBAction func playEchoAudio(sender: UIButton) {
        resetPlayers()
        audioPlayer.currentTime = 0;
        audioPlayer.play()
        let delay:NSTimeInterval = 0.05
        var playtime:NSTimeInterval
        playtime = audioPlayer2.deviceCurrentTime + delay
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.6;
        audioPlayer2.playAtTime(playtime)
        
    }
    
    //Add reverb effect to audio
    @IBAction func playReverbAudio(sender: UIButton)
    {
        resetPlayers()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var reverb = AVAudioUnitReverb()
        reverb.wetDryMix = 50
       
        audioEngine.attachNode(reverb)
        
        audioEngine.connect(audioPlayerNode, to: reverb, format: nil)
        audioEngine.connect(reverb, to: audioEngine.outputNode , format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    //Stop and reset audioPlayers
    @IBAction func stopPlaying(sender: UIButton) {
        resetPlayers()
    }
    
}
