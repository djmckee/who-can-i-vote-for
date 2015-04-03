//
//  AboutWebViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 03/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class AboutWebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "About"

        // Do any additional setup after loading the view.
        // Load our about html file into the webview...
        let url = NSBundle.mainBundle().URLForResource("About", withExtension:"html")
        
        // get HTML.
        let pageContents = NSString(contentsOfURL: url!, encoding:NSUTF8StringEncoding, error: nil)
        
        // load it.
        webView?.loadHTMLString(pageContents, baseURL: nil)

    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {

        if navigationType == UIWebViewNavigationType.LinkClicked {
            // don't load new pages! force them into safari... (after asking)
            
            let alertController = UIAlertController(title: "Open in Safari?", message: "Would you like to open this link in Safari?", preferredStyle: .Alert)
            
            
            let cancelAction = UIAlertAction(title: "No", style: .Default, handler: nil)

            alertController.addAction(cancelAction)
            
            
            let openAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
                // open in Safari...
                UIApplication.sharedApplication().openURL(request.URL)
                return
            }
            
            alertController.addAction(openAction)

            self.presentViewController(alertController, animated: true, completion: nil)
            
            
            return false
        }
        
        // otherwise do it
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
