//
//  ViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    var currentLocation:CLLocation!
    let locationManager = CLLocationManager()

    
    // instance variables to facilitate object passing between seuges nicely.
    var constituenciesList:Array<Constituency>! = []
    var candidatesList:Array<Candidate>! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        // Style it up
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Futura-Medium", size: 22)!]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        // fire up corelocation, making ourselves the delegate
        locationManager.delegate = self
        
        // we want decent accuracy, but only update us if the user moves about 100 meters...
        locationManager.distanceFilter = 100
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // we wanna request auth. first...
        locationManager.requestWhenInUseAuthorization()
        
        // and start updates...
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // Hide navigation bar!!!!1
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        // Show navigation bar (so other views can use it)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openWebsiteClicked(sender: UIButton) {
        // open http://yournextmp.com in the browser.
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yournextmp.com")!)
    }
    
    @IBAction func findByLocation(sender: UIButton) {
        // check connection...
        if !reachabilityCheck() {
            return
        }
        
        // okay first check we have a current location - if we don't, we can't find anything from nothing...
        if currentLocation == nil {
            // alert the user then return.
            println("no current location!")

            let alertController = UIAlertController(title: "No location found", message: "We're sorry but we can't find your current location at the moment. Please try another method.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                // nothing to do really.
            }
            
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        // we definitely have a location by this point... use it!
        // start loading UI...
        SwiftSpinner.show("Locating constituency", animated: true)
        
        // now search...
        YourNextMPAPIManager.getConstituencyWithCoordinate(currentLocation.coordinate, completionHandler: { (c) -> () in
            self.loadCandidatesForConstituency(c!)
            
        })
    }
    
    @IBAction func findByPostcode(sender: UIButton) {
        // check connection...
        if !reachabilityCheck() {
            return
        }
        
        // get postcode in an alert...
        let alertController = UIAlertController(title: "Enter Postcode", message: nil, preferredStyle: .Alert)
        
        // and a simple cancel button too!
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in
            // do nothing really.
        }
        alertController.addAction(cancelAction)
        
        // we need the text field/it's behaviour set up...
        let postcodeSearch = UIAlertAction(title: "Search", style: .Default) { (_) in
            // get text field
            let searchTextField = alertController.textFields![0] as UITextField
            
            // remove whitespace!!!!
            let postcode:String = searchTextField.text.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            
            // start loading UI...
            SwiftSpinner.show("Locating constituency", animated: true)
            
            // now search...
            YourNextMPAPIManager.getConstituencyWithPostcode(postcode, completionHandler: { (c) -> () in
                self.loadCandidatesForConstituency(c!)
                
            })
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            // placeholder so the user knows what to do...
            textField.placeholder = "Enter postcode"
        }
        
        alertController.addAction(postcodeSearch)

        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func findByConstituencyList(sender: UIButton) {
        // check connection...
        if !reachabilityCheck() {
            return
        }
        
        // bit of loading UI...
        SwiftSpinner.show("Loading constituencies...", animated: true)
        
        // load ConstituencyTableViewController (after getting constituencies!)
        YourNextMPAPIManager.getConstituencies { (c) -> () in
            // hide loading UI
            SwiftSpinner.hide()
            
            // load it! (via constituenciesListSegue)
            self.constituenciesList = c
            self.performSegueWithIdentifier("constituenciesListSegue", sender: self)
        }
    }
    
    
    func invalidConstituency() {
        // a generic 'not valid constituency' warning - ask the user to try again in an alert.
        let alertController = UIAlertController(title: "Cannot find constituency", message: "We're sorry but we can't find your constituency. Please try another method of locating it, or choose it from the list instead.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
            // nothing to do really.
        }
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func loadCandidatesForConstituency(c:Constituency){
        // see if it's valid...
        if c.idNumber == -1 {
            // invalid constituency!
            SwiftSpinner.hide()
            self.invalidConstituency();
            return
        }
        
        // get candidates... update loading UI too
        SwiftSpinner.show("Finding candidates", animated: true)
        
        
        YourNextMPAPIManager.getCandidatesInConstituency(c, completionHandler: { (candidates) -> () in
            // load a candidate list!
            SwiftSpinner.hide()
            
            self.candidatesList = candidates
            self.performSegueWithIdentifier("candidatesListSegue", sender: self)
            
        })
        
    }

    func reachabilityCheck() -> Bool{
        if Reachability.reachabilityForInternetConnection().currentReachabilityStatus == Reachability.NetworkStatus.NotReachable {
            // noo!
            // alert the user and return false...
            let alertController = UIAlertController(title: "No internet connection", message: "We're sorry but this app requires data from the Internet. Please check your Internet connection and try again.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                // nothing to do really.
            }
            
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        // must be reachable then...
        return true
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // last location is the most recent
        // (typecasting saves all)
        currentLocation = locations.last as CLLocation
        //println("updated location to: " + currentLocation.description)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        // grr. not much we can do.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "constituenciesListSegue" {
            // pre-load constituencies in!
            var viewController:ConstituencyTableViewController = segue.destinationViewController as ConstituencyTableViewController
            viewController.constituencyArray = self.constituenciesList
        }
        
        if segue.identifier == "candidatesListSegue" {
            // load candidates in
            var viewController:CandidateTableViewController = segue.destinationViewController as CandidateTableViewController
            viewController.candidateArray = self.candidatesList
        }
    }
    
    
}

