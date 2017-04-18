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
        let url = Bundle.main.url(forResource: "About", withExtension:"html")
        
        
        do {
            // get HTML.
            let pageContents = try NSString(contentsOf: url!, encoding: String.Encoding.utf8.rawValue)
            
            // load it.
            webView!.loadHTMLString(pageContents as String, baseURL: nil)

            
        } catch {
            
        }
        
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {

        if navigationType == UIWebViewNavigationType.linkClicked {
            // don't load new pages! force them into safari... (after asking)
            
            let alertController = UIAlertController(title: "Open in Safari?", message: "Would you like to open this link in Safari?", preferredStyle: .alert)
            
            
            let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)

            alertController.addAction(cancelAction)
            
            
            let openAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                // open in Safari...
                UIApplication.shared.openURL(request.url!)
                return
            }
            
            alertController.addAction(openAction)

            self.present(alertController, animated: true, completion: nil)
            
            
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
