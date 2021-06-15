//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
  
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var timerView: UILabel!
    
    var progress = Progress(totalUnitCount: 0)
    let eggTimes = ["Soft": 5, "Medium": 7,"Hard": 12]
    var count = 0
    var timer = Timer()
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
        timerView.text = "0 Seconds"
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        count = 1 * eggTimes[hardness]!
        
        progress = Progress(totalUnitCount: Int64(count))
        progressView.progress = 0.0
        progress.completedUnitCount = 0
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
            
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
    @objc func countDown() {
        
        timerView.text = "\(count) seconds remaining"
        count -= 1
        progress.completedUnitCount += 1
        progressView.setProgress(Float(progress.fractionCompleted), animated: true)
        
        if count < 0 {
            timer.invalidate()
            playSound(soundName: "alarm_sound")
            timerView.text = "Remove your eggs"
        }

            
        
    }


    

}
