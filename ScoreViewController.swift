//
//  ScoreViewController.swift
//  BoutTime
//
//  Created by Mark Erickson on 8/14/16.
//  Copyright © 2016 Mark Erickson. All rights reserved.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var scoreString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = scoreString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
