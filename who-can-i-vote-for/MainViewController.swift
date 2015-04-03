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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
 
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
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // last location is the most recent
        // (typecasting saves all)
        currentLocation = locations.last as CLLocation
        println("updated location to: " + currentLocation.description)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        // grr. not much we can do.
    }
    
    
}

