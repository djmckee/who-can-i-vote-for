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
        
        // if we're on iOS 8, we wanna request auth. first...
        if locationManager.respondsToSelector(Selector(locationManager.requestWhenInUseAuthorization())){
            locationManager.requestWhenInUseAuthorization()
        }
        
        // and start updates...
        locationManager.startUpdatingLocation()
        
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
            
            let locationAlert = UIAlertView()
            locationAlert.title = "No location found"
            locationAlert.message = "We're sorry but we can't find your current location at the moment. Please try another method."
            locationAlert.addButtonWithTitle("Okay")
            locationAlert.show()
            
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

