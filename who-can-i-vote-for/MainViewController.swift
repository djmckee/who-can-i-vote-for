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
        
        //APIManager.getConstituencyWithPostcode("NE17RU")
        // begin loading UI...

        YourNextMPAPIManager.getConstituencyWithCoordinate(CLLocationCoordinate2DMake(54.9791871, -1.6146608)) { (c) -> () in
            YourNextMPAPIManager.getCandidatesInConstituency(c!, {(candidates) -> ()
                in
                //SwiftSpinner.hide()
                println(candidates)
            })
            return
        }
        
        //YourNextMPAPIManager.getCandidatesInConstituency(Constituency(constituencyId: 66055))
        
        
        //YourNextMPAPIManager.getConstituencies()
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
    
    @IBAction func findByPostcode(sender: UIButton) {
        // get postcode in an alert...
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
        
        // we need the text field/it's behaviour set up...
        let postcodeSearch = UIAlertAction(title: "Login", style: .Default) { (_) in
            // get text field
            let searchTextField = alertController.textFields![0] as UITextField
            
            // start loading UI...
            SwiftSpinner.show("Locating constituency")
            
            // now search...
            YourNextMPAPIManager.getConstituencyWithPostcode(searchTextField.text, completionHandler: { (c) -> () in
                // see if it's valid...
                if c?.idNumber == -1 {
                    // invalid constituency!
                    self.invalidConstituency();
                    return
                }
                
                // it's real, carry on!
                // get candidates... update loading UI too
                SwiftSpinner.show("Finding candidates")
                
                YourNextMPAPIManager.getCandidatesInConstituency(c!, completionHandler: { (candidates) -> () in
                    // load a candidate list!
                    SwiftSpinner.hide()
                    
                    self.candidatesList = candidates
                    self.performSegueWithIdentifier("candidatesListSegue", sender: self)
                    
                })
                
            })
        }
        postcodeSearch.enabled = false
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            // placeholder so the user knows what to do...
            textField.placeholder = "Enter postcode"
        }
        
        alertController.addAction(postcodeSearch)
        
        // and a simple cancel button too!
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in
            // do nothing really.
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func findByConstituencyList(sender: UIButton) {
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
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // last location is the most recent
        // (typecasting saves all)
        currentLocation = locations.last as CLLocation
        println("updated location to: " + currentLocation.description)
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

