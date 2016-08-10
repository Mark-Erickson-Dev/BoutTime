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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nextRoundButton.hidden = true
        instructionLabel.text = "Shake to complete"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func eventDown(sender: AnyObject) {
        
        let button = sender as! UIButton
        button.setBackgroundImage(UIImage(named: "down_full_selected"), forState: .Normal)
        
        print("Button \(button.tag) was pressed!")
        
    }

}

