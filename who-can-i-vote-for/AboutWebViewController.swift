//
//  AboutWebViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 03/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class AboutWebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Load our about html file into the webview...
        let url = NSBundle.mainBundle().URLForResource("About", withExtension:"html")
        
        // get HTML.
        let pageContents = NSString(contentsOfURL: url!, encoding:NSUTF8StringEncoding, error: nil)
        
        // load it.
        webView?.loadHTMLString(pageContents, baseURL: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
