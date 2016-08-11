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
    
    @IBOutlet weak var event1DownButton: UIButton!
    @IBOutlet weak var event2UpButton: UIButton!
    @IBOutlet weak var event2DownButton: UIButton!
    @IBOutlet weak var event3UpButton: UIButton!
    @IBOutlet weak var event3DownButton: UIButton!
    @IBOutlet weak var event4UpButton: UIButton!
    
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    let allEvents = ["Event1", "Event2", "Event3", "Event4", "Event5", "Event6", "Event7", "Event8", "Event9", "Event10", ]
    
    let originalEvents = ["Event1", "Event2", "Event3", "Event4"]
    
    var userSetEvents = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userSetEvents = originalEvents
        
        setupButtons()
        
        nextRoundButton.hidden = true
        instructionLabel.text = "Shake to complete"
        
        setupEvents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func eventDown(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        print("Button \(button.tag) was pressed!")
        
        var tempEvents = userSetEvents
        
        print(tempEvents)
        
        let temp = userSetEvents[button.tag + 1]
        
        tempEvents.removeAtIndex(button.tag + 1)
        tempEvents.insert(temp, atIndex: button.tag)
        
        print(tempEvents)

        userSetEvents = tempEvents
        setupEvents()
    
    }
    
    @IBAction func eventUp(sender: AnyObject) {
        
        let button = sender as! UIButton
        
        print("Button \(button.tag) was pressed!")
        
        var tempEvents = userSetEvents
        
        print(tempEvents)
        
        let temp = userSetEvents[button.tag - 1]
        
        tempEvents.removeAtIndex(button.tag - 1)
        tempEvents.insert(temp, atIndex: button.tag)
        
        print(tempEvents)
        
        userSetEvents = tempEvents
        setupEvents()
        
    }
    
    func setupEvents() {
        event1Label.text = userSetEvents[0]
        event2Label.text = userSetEvents[1]
        event3Label.text = userSetEvents[2]
        event4Label.text = userSetEvents[3]
    }
    
    func setupButtons() {
        event1DownButton.setBackgroundImage(UIImage(named: "down_full_selected"), forState: .Highlighted)
        event2UpButton.setBackgroundImage(UIImage(named: "up_half_selected"), forState: .Highlighted)
        event2DownButton.setBackgroundImage(UIImage(named: "down_half_selected"), forState: .Highlighted)
        event3UpButton.setBackgroundImage(UIImage(named: "up_half_selected"), forState: .Highlighted)
        event3DownButton.setBackgroundImage(UIImage(named: "down_half_selected"), forState: .Highlighted)
        event4UpButton.setBackgroundImage(UIImage(named: "up_full_selected"), forState: .Highlighted)
    }

}

