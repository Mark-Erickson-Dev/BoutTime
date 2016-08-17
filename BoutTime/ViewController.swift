//
//  ViewController.swift
//  BoutTime
//
//  Created by Mark Erickson on 8/8/16.
//  Copyright © 2016 Mark Erickson. All rights reserved.
//

import UIKit
//import GameKit

class ViewController: UIViewController {

    @IBOutlet weak var event1Label: UILabel!
    @IBOutlet weak var event2Label: UILabel!
    @IBOutlet weak var event3Label: UILabel!
    @IBOutlet weak var event4Label: UILabel!
    
    @IBOutlet weak var event1Button: UIButton!
    @IBOutlet weak var event2Button: UIButton!
    @IBOutlet weak var event3Button: UIButton!
    @IBOutlet weak var event4Button: UIButton!
    
    @IBOutlet weak var event1DownButton: UIButton!
    @IBOutlet weak var event2UpButton: UIButton!
    @IBOutlet weak var event2DownButton: UIButton!
    @IBOutlet weak var event3UpButton: UIButton!
    @IBOutlet weak var event3DownButton: UIButton!
    @IBOutlet weak var event4UpButton: UIButton!
    
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    let allEvents = EventSet().allEvents
    var eventIndexes = [Int]()
    var randomEvents = [Event]()
    var correctEvents = [Event]()
    let maxSeconds = 30
    var seconds = 0
    var timer = NSTimer()
    let eventsPerRound = 4
    var randomIndex = 0
    var correctAnswers = 0
    let numberOfRounds = 3
    var roundCount = 0
    var isNextRound = true
    var isShakeable = true
    
    enum Result {
        case Success
        case Failure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        setupRound()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        
        printTimeString()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    func updateTimer() {
        
        seconds -= 1
        if seconds == 0 {
            //print("Time's up")
            checkResults()
        }
        
        printTimeString()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == .MotionShake {
            
            if isShakeable == true {
                checkResults()
            }
        }
    }
    
    @IBAction func openWebView(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        //print("event\(button.tag) label pressed")
        
        performSegueWithIdentifier("showWebView", sender: button)
        
    }

    @IBAction func eventDown(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        //print("Button \(button.tag) was pressed!")
        
        var tempEvents = randomEvents
        
        //print(tempEvents)
        
        let temp = randomEvents[button.tag + 1]
        
        tempEvents.removeAtIndex(button.tag + 1)
        tempEvents.insert(temp, atIndex: button.tag)
        
        //print(tempEvents)

        randomEvents = tempEvents
        setupEvents()
    
    }
    
    @IBAction func eventUp(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        //print("Button \(button.tag) was pressed!")
        
        var tempEvents = randomEvents
        
        //print(tempEvents)
        
        let temp = randomEvents[button.tag - 1]
        
        tempEvents.removeAtIndex(button.tag - 1)
        tempEvents.insert(temp, atIndex: button.tag)
        
        //print(tempEvents)
        
        randomEvents = tempEvents
        setupEvents()
        
    }
    
    @IBAction func nextRound(sender: AnyObject) {
        
        //print("next round pressed")
        randomEvents.removeAll()
        correctEvents.removeAll()
        eventIndexes.removeAll()
        
        if roundCount == numberOfRounds{
            
            isNextRound = false
            displayScore()
            
        } else {
            
            setupRound()
        }

    }
    
    func setupEvents() {
        event1Label.text = randomEvents[0].description
        event2Label.text = randomEvents[1].description
        event3Label.text = randomEvents[2].description
        event4Label.text = randomEvents[3].description
    }
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.displayScore()
        }
    }
    
    func setupRound() {
        
        isNextRound = true
        isShakeable = true
        
        event1Button.enabled = false
        event2Button.enabled = false
        event3Button.enabled = false
        event4Button.enabled = false
        
        nextRoundButton.enabled = true
        nextRoundButton.hidden = true
        seconds = maxSeconds
        timerLabel.hidden = false
        instructionLabel.text = "Shake to complete"
        
        getEvents()
        
        correctEvents = randomEvents.sort {
            $0.date.localizedCaseInsensitiveCompare($1.date) == NSComparisonResult.OrderedAscending
        }
        
        setupEvents()
        startTimer()
        
    }
    
    func setupButtons() {
        event1DownButton.setBackgroundImage(UIImage(named: "down_full_selected"), forState: .Highlighted)
        event2UpButton.setBackgroundImage(UIImage(named: "up_half_selected"), forState: .Highlighted)
        event2DownButton.setBackgroundImage(UIImage(named: "down_half_selected"), forState: .Highlighted)
        event3UpButton.setBackgroundImage(UIImage(named: "up_half_selected"), forState: .Highlighted)
        event3DownButton.setBackgroundImage(UIImage(named: "down_half_selected"), forState: .Highlighted)
        event4UpButton.setBackgroundImage(UIImage(named: "up_full_selected"), forState: .Highlighted)
        
        event1Button.layer.cornerRadius = 5
        event2Button.layer.cornerRadius = 5
        event3Button.layer.cornerRadius = 5
        event4Button.layer.cornerRadius = 5
    }
    
    func checkResults() {
        
        for i in 0 ..< randomEvents.count {
            guard randomEvents[i].date == correctEvents[i].date else {
                
                displayResults(.Failure)
                return
            }
        }
        
        displayResults(.Success)
        
    }
    
    func displayResults(result: Result) {

        event1Button.enabled = true
        event2Button.enabled = true
        event3Button.enabled = true
        event4Button.enabled = true
        
        timer.invalidate()
        timerLabel.hidden = true
        nextRoundButton.hidden = false
        instructionLabel.text = "Tap events to learn more"
        
        switch result {
        case .Failure:
            nextRoundButton.setBackgroundImage(UIImage(named: "next_round_fail"), forState: .Normal)
            //print("Wrong!")
        case .Success:
            nextRoundButton.setBackgroundImage(UIImage(named: "next_round_success"), forState: .Normal)
            correctAnswers += 1
            //print("All correct!!!!")
        }
        
        roundCount += 1
        isShakeable = false

    }
    
    @IBAction func unwindSecondView(segue: UIStoryboardSegue) {
        //print("unwind fired in first view")
        
        if isNextRound == false {
            
            setupRound()
            
        }
    }
    
    func displayScore() {
        
        //print("Your Score \(correctAnswers)/\(numberOfRounds)")
        
        roundCount = 0
        
        performSegueWithIdentifier("showScore", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showScore" {
            if let destinationView = segue.destinationViewController as? ScoreViewController {
                
                destinationView.scoreString = "\(correctAnswers)/\(numberOfRounds)"
                correctAnswers = 0
                
            }
        }
        
        if segue.identifier == "showWebView" {
            if let button = sender as? UIButton {
                
               //print("prepareforsegue \(button.tag)")
               //print(randomEvents[button.tag].url)
                let url = randomEvents[button.tag].url
                
                if let destinationView = segue.destinationViewController as? WebViewController {
                    
                    destinationView.url = url
                    
                }
            }
        }
    }
    
    func getEvents() {
        
        while randomEvents.count < eventsPerRound {
            repeat {
                
                randomIndex = Int(arc4random_uniform(UInt32(allEvents.count)))
                //randomIndex = GKRandomSource.sharedRandom().nextIntWithUpperBound(allEvents.count)
                //print(randomIndex)
                
            } while eventIndexes.contains(randomIndex) == true
            
            eventIndexes.append(randomIndex)
            //print(eventIndexes)
            
            randomEvents.append(allEvents[randomIndex])
            
        }
    }
    
    func printTimeString() {
        
        let timeString = String(format: "%0d:%02d", 0, seconds)
        timerLabel.text = timeString
        
    }

}

