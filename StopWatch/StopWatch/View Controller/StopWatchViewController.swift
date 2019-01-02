//
//  ViewController.swift
//  StopWatch
//
//  Created by Calvin Cantin on 18-09-30.
//  Copyright © 2018 Calvin Cantin. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetAndLapButton: UIButton!
    @IBOutlet weak var startAndStopButton: UIButton!
    var centieme = 0
    var seconds = 0
    var minutes = 0
    var hours = 0
    var timer = Timer()
    var laps:[Lap] = []
    var isTiming:Bool = false
    @IBAction func startAndStopButtonPressed(_ sender: UIButton) {
        if isTiming == false
        {
            startAndStopButton.setTitle("Stop", for: .normal)
            resetAndLapButton.setTitle("Lap", for: .normal)
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimeLabel) , userInfo: nil, repeats: true)
            isTiming = true
        }
        else if isTiming == true
        {
            startAndStopButton.setTitle("Start", for: .normal)
            timer.invalidate()
            isTiming = false
            resetAndLapButton.setTitle("Reset", for: .normal)
        }
    }
    @IBAction func resetAndLapButtonTapped(_ sender: UIButton) {
        centieme = -1
        seconds = 0
        minutes = 0
        hours = 0
        updateTimeLabel()
        guard isTiming  == false else {return}
        resetAndLapButton.isEnabled = false
    }
    
    @objc func updateTimeLabel()
    {
        centieme += 1
        if  centieme == 100
        {
            seconds += 1
            centieme = 0
        }
        if seconds == 60
        {
            minutes += 1
            seconds = 0
        }
        if minutes == 60
        {
            hours += 1
            minutes = 0
        }
        var centiemeString = "\(centieme)"
        var secondString = "\(seconds)"
        var minuteString = "\(minutes)"
        var hoursString = "\(hours)"
        if centieme < 10
        {
            centiemeString = "0\(centieme)"
        }
        if seconds < 10
        {
            secondString = "0\(seconds)"
        }
        if minutes < 10
        {
            minuteString = "0\(minutes)"
        }
        if hours < 10
        {
            hoursString = "0\(minutes)"
        }
        guard minutes < 60 else {
            timeLabel.text = "\(hoursString):\(minuteString):\(secondString)"
            return
        }
        timeLabel.text = "\(minuteString):\(secondString):\(centiemeString)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetAndLapButton.isEnabled = false
        let someFont:UIFont = UIFont.monospacedDigitSystemFont(ofSize: 59, weight: UIFont.Weight.regular)
        timeLabel.font = someFont
        // Do any additional setup after loading the view, typically from a nib.
    }


}

