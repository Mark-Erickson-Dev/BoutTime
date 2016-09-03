//
//  WebViewController.swift
//  BoutTime
//
//  Created by Mark Erickson on 8/14/16.
//  Copyright © 2016 Mark Erickson. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadURL() {
        
        // Create a url request and load it into the webview
        if let requestURL = NSURL(string: url) {
            
            let request = NSURLRequest(URL: requestURL)
            
            webview.loadRequest(request)
        }
    }

}