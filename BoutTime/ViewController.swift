//
//  ViewController.swift
//  BoutTime
//
//  Created by Mark Erickson on 8/8/16.
//  Copyright © 2016 Mark Erickson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var event1Label: UILabel!
    @IBOutlet weak var event2Label: UILabel!
    @IBOutlet weak var event3Label: UILabel!
    @IBOutlet weak var event4Label: UILabel!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
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
    let maxSeconds = 60
    var seconds = 0
    var timer = NSTimer()
    let eventsPerRound = 4
    var randomIndex = 0
    var correctAnswers = 0
    let numberOfRounds = 6
    var roundCount = 0
    var isNextRound = true
    var isShakeable = true
    
    enum Result {
        
        case Success
        case Failure
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonsAndLabels()
        setupRound()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getEvents() {
        
        // Fill array with random events
        while randomEvents.count < eventsPerRound {
            
            // Select a random index for an event that is not repeated in a single round
            repeat {
                randomIndex = Int(arc4random_uniform(UInt32(allEvents.count)))
            } while eventIndexes.contains(randomIndex) == true
            
            // Add the index to the eventIndexes array
            eventIndexes.append(randomIndex)
            
            // Add the random event to the randomEvents array
            randomEvents.append(allEvents[randomIndex])
            
        }
        
    }
    
    func displayEvents() {
        
        // Set event labels to display the randomEvents descriptions
        event1Label.text = randomEvents[0].description
        event2Label.text = randomEvents[1].description
        event3Label.text = randomEvents[2].description
        event4Label.text = randomEvents[3].description
        
    }
    
    func checkResults() {
        
        // Loop through events to see if they match the correct events
        for i in 0 ..< randomEvents.count {
            // If the current event does not match the correct event, at the same index, display failure
            guard randomEvents[i].date == correctEvents[i].date else {
                displayResults(.Failure)
                return
            }
        }
        
        // Display success if all events are correct
        displayResults(.Success)
        
    }
    
    func displayResults(result: Result) {
        
        // Diable event buttons
        event1Button.enabled = true
        event2Button.enabled = true
        event3Button.enabled = true
        event4Button.enabled = true
        
        // Stop timer and hide it
        timer.invalidate()
        timerLabel.hidden = true
        
        // Show nextRoundButton and instructions
        nextRoundButton.hidden = false
        instructionLabel.text = "Tap events to learn more"
        
        switch result {
        case .Failure:
            // Show failure image
            nextRoundButton.setBackgroundImage(UIImage(named: "next_round_fail"), forState: .Normal)
        case .Success:
            // Show success image and increment correctAnswers count
            nextRoundButton.setBackgroundImage(UIImage(named: "next_round_success"), forState: .Normal)
            correctAnswers += 1
        }
        
        // Increment roundCount and indicate not shakeable
        roundCount += 1
        isShakeable = false
        
    }
    
    @IBAction func nextRound(sender: AnyObject) {
        
        // Empty arrays to prepare for the next round
        randomEvents.removeAll()
        correctEvents.removeAll()
        eventIndexes.removeAll()
        
        // Check for end of game
        if roundCount == numberOfRounds{
            isNextRound = false
            displayScore()
        } else {
            setupRound()
        }
        
    }
    
    func displayScore() {
        
        // Reset roundCount and segue to the ScoreViewController
        roundCount = 0
        performSegueWithIdentifier("showScore", sender: nil)
        
    }
    
    @IBAction func eventDown(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        // Copy randomEvents into a temporary array
        var tempEvents = randomEvents
        
        // Copy the event that corresponds to the down button pressed into a temporary variable
        let temp = randomEvents[button.tag + 1]
        
        // Switch the current event with the event below
        tempEvents.removeAtIndex(button.tag + 1)
        tempEvents.insert(temp, atIndex: button.tag)

        // Set randomEvents to the now rearranged array(tempEvents) and display the events
        randomEvents = tempEvents
        displayEvents()
    
    }
    
    @IBAction func eventUp(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        // Copy randomEvents into a temporary array
        var tempEvents = randomEvents
        
        // Copy the event that corresponds to the down button pressed into a temporary variable
        let temp = randomEvents[button.tag - 1]
        
        // Switch the current event with the event above
        tempEvents.removeAtIndex(button.tag - 1)
        tempEvents.insert(temp, atIndex: button.tag)
        
        // Set randomEvents to the now rearranged array(tempEvents) and display the events
        randomEvents = tempEvents
        displayEvents()
        
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showScore" {
            
            // Pass the score to the ScoreViewController and reset the correctAnswers count
            if let destinationView = segue.destinationViewController as? ScoreViewController {
                destinationView.scoreString = "\(correctAnswers)/\(numberOfRounds)"
                correctAnswers = 0
            }
        }
        
        if segue.identifier == "showWebView" {
            if let button = sender as? UIButton {
                
                // Pass the url to the WebViewController according to the event tapped
                let url = randomEvents[button.tag].url
                if let destinationView = segue.destinationViewController as? WebViewController {
                    destinationView.url = url
                }
            }
        }
    }
    
    @IBAction func openWebView(sender: AnyObject) {
        
        // Segue to the WebViewController when an event is tapped
        let button = sender as! UIButton
        performSegueWithIdentifier("showWebView", sender: button)
        
    }
    
    @IBAction func unwindSecondView(segue: UIStoryboardSegue) {
        
        // If unwinding from ScoreViewController, setup the next round
        if isNextRound == false {
            setupRound()
        }
    }
    
    // MARK: Helper Methods
    
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
        
        // Indicate next round and ability to shake
        isNextRound = true
        isShakeable = true
        
        // Disable event buttons, and hide nextRoundButton
        event1Button.enabled = false
        event2Button.enabled = false
        event3Button.enabled = false
        event4Button.enabled = false
        nextRoundButton.enabled = true
        nextRoundButton.hidden = true
        
        // Reset seconds to max, show timer
        seconds = maxSeconds
        timerLabel.hidden = false
        instructionLabel.text = "Shake to complete"
        
        // Get a random set of events for the round
        getEvents()
        
        // Sort the events by date
        correctEvents = randomEvents.sort {
            $0.date.localizedCaseInsensitiveCompare($1.date) == NSComparisonResult.OrderedAscending
        }
        
        // Display events and start timer
        displayEvents()
        startTimer()
        
    }
    
    func setupButtonsAndLabels() {
        
        // Set the image to display when down/up buttons are selected
        event1DownButton.setBackgroundImage(UIImage(named: "down_full_selected"), forState: .Highlighted)
        event2UpButton.setBackgroundImage(UIImage(named: "up_half_selected"), forState: .Highlighted)
        event2DownButton.setBackgroundImage(UIImage(named: "down_half_selected"), forState: .Highlighted)
        event3UpButton.setBackgroundImage(UIImage(named: "up_half_selected"), forState: .Highlighted)
        event3DownButton.setBackgroundImage(UIImage(named: "down_half_selected"), forState: .Highlighted)
        event4UpButton.setBackgroundImage(UIImage(named: "up_full_selected"), forState: .Highlighted)
        
        // Round the corners of the buttons and labels
        event1Button.layer.cornerRadius = 5
        event2Button.layer.cornerRadius = 5
        event3Button.layer.cornerRadius = 5
        event4Button.layer.cornerRadius = 5
        
        firstLabel.layer.masksToBounds = true
        firstLabel.layer.cornerRadius = 20
        secondLabel.layer.masksToBounds = true
        secondLabel.layer.cornerRadius = 20
        thirdLabel.layer.masksToBounds = true
        thirdLabel.layer.cornerRadius = 20
        fourthLabel.layer.masksToBounds = true
        fourthLabel.layer.cornerRadius = 20
        
    }
    
    func startTimer() {
        
        // Create a timer object that will update every second
        printTimeString()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    func updateTimer() {
        
        // Decrement the seconds count
        seconds -= 1
        
        // Check the answer results if the timer hits 0
        if seconds == 0 {
            checkResults()
        }
        
        printTimeString()
    }
    
    func printTimeString() {
        
        // Format the timeString
        let timeString = String(format: "%0d:%02d", 0, seconds)
        timerLabel.text = timeString
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        // Check if the device was shaken
        if event?.subtype == .MotionShake {
            if isShakeable == true {
                checkResults()
            }
        }
        
    }
    
}

