//
//  ViewController.swift
//  Pomodoro App
//
//  Created by Gamalliel Sharon on 07/01/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    let pomodoroTimes = [
        "Study": 1500,
        "Break": 300
    ]
    var totalTime = 0
    var secondPassed = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let items = sender.currentTitle!
        timer.invalidate()
        totalTime = pomodoroTimes[items]!
        secondPassed = 0
        titleLabel.text = items
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    @objc func updateCounter() {
        if secondPassed <= totalTime{
            progressBar.progress = Float(secondPassed) / Float(totalTime)
            secondPassed += 1
        }else{
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "leisure_video_game_music_level_complete", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

