//
//  ViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftSpinner
import ReachabilitySwift
import Alamofire
import PermissionScope

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    var currentLocation:CLLocation!
    let locationManager = CLLocationManager()
    let pscope = PermissionScope()

    
    // instance variables to facilitate object passing between seuges nicely.
    var constituenciesList:Array<Constituency>! = []
    var candidatesList:Array<Candidate>! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        // Style it up
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Futura-Medium", size: 22)!]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as! [AnyHashable : Any] as [AnyHashable: Any] as! [String : Any]
        
        // fire up corelocation, making ourselves the delegate
        locationManager.delegate = self
        
        // we want decent accuracy, but only update us if the user moves about 100 meters...
        locationManager.distanceFilter = 100
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        
        
        let brandColor = self.view.backgroundColor!
        pscope.closeButtonTextColor = brandColor
        pscope.permissionButtonTextColor = brandColor
        pscope.permissionButtonBorderColor = brandColor
        pscope.authorizedButtonColor = brandColor
        pscope.unauthorizedButtonColor = brandColor
        
        let fontName = "Futura-Medium"
        let labelFont = UIFont(name: fontName, size: 15.0)!
        let bolderFont = UIFont(name: fontName, size: 16.0)!
        let biggerBolderFont = UIFont(name: fontName, size: 19.0)!
        
        pscope.labelFont = labelFont
        pscope.bodyLabel.font = labelFont
        pscope.buttonFont = bolderFont
        pscope.headerLabel.font = biggerBolderFont
        
        
        pscope.headerLabel.text? = "Get started"
        pscope.bodyLabel.numberOfLines = 3
        
        // Set up permissions
        pscope.addPermission(NotificationsPermission(),
                             message: "To remind you on Election Day.")
        pscope.addPermission(LocationWhileInUsePermission(),
                             message: "Used to find your local MP.")
        
        // Show dialog with callbacks
        pscope.show({ finished, results in
            print("got results \(results)")
            
            // and start updates...
            self.locationManager.startUpdatingLocation()
            
            
            // Register for notifications...
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types:UIUserNotificationType.alert, categories: nil))
            
            self.scheduleReminder()
            
            
        }, cancelled: { (results) -> Void in
            print("thing was cancelled")
        })
        
    }
    
    func scheduleReminder() {
        // check NSUserDefaults - if it's a first launch for this election year, schedule a notification to remind teh user to vote!
        let defaults = UserDefaults.standard
        let launchedBeforeKey = "launchedBeforeElection2017"
        let launchedBefore:Bool = defaults.bool(forKey: launchedBeforeKey)
        
        // if they haven't launched us before, let's try and notify!
        if !launchedBefore {
            // create our notification
            let localNotification:UILocalNotification = UILocalNotification()
            // appropriate body
            
            localNotification.alertBody = "☑️❗️ Remember to vote today!"
            
            // UNIX timestamp for 7am GMT (so 8am local UK time) on June 8th is 1496905200 - thanks http://www.epochconverter.com/
            localNotification.fireDate = Date(timeIntervalSince1970: 1496905200)
            
            // let's schedule this...
            UIApplication.shared.scheduleLocalNotification(localNotification)
            
            // and set the key so they don't get bombarded!
            defaults.set(true, forKey:launchedBeforeKey)
            
            // sync 'n save...
            defaults.synchronize()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Hide navigation bar!!!!1
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Show navigation bar (so other views can use it)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openWebsiteClicked(_ sender: UIButton) {
        // open http://yournextmp.com in the browser.
        UIApplication.shared.openURL(URL(string: "http://yournextmp.com")!)
    }
    
    @IBAction func findByLocation(_ sender: UIButton) {
        // check connection...
        if !reachabilityCheck() {
            return
        }
        
        if let newLoc = self.locationManager.location {
            self.currentLocation = newLoc
        }
        
        // okay first check we have a current location - if we don't, we can't find anything from nothing...
        if currentLocation == nil {
            // alert the user then return.
            print("no current location!")

            let alertController = UIAlertController(title: "No location found", message: "We're sorry but we can't find your current location at the moment. Please try another method.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                // nothing to do really.
            }
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
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
    
    @IBAction func findByPostcode(_ sender: UIButton) {
        // check connection...
        if !reachabilityCheck() {
            return
        }
        
        // get postcode in an alert...
        let alertController = UIAlertController(title: "Enter Postcode", message: nil, preferredStyle: .alert)
        
        // and a simple cancel button too!
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        // we need the text field/it's behaviour set up...
        let postcodeSearch = UIAlertAction(title: "Search", style: .default) { (_) in
            // get text field
            let searchTextField = alertController.textFields![0] 
            
            // remove whitespace!!!!
            let postcode:String = (searchTextField.text?.replacingOccurrences(of: " ", with: ""))!
            
            // basic invalid entry checking...
            if postcode.characters.count < 5 {
                // obviously not valid.
                // (shortest postcode is 5 chars. according to http://www.answers.com/Q/What_is_the_shortest_postal_code_in_UK - and we've removed whitespace by this point too).
                // alert user, give up, go home.
                self.invalidConstituency()
                return
            }
            
            // start loading UI...
            SwiftSpinner.show("Locating constituency", animated: true)
            
            // now search...
            YourNextMPAPIManager.getConstituencyWithPostcode(postcode, completionHandler: { (c) -> () in
                print("completed getConstituencyWithPostcode")
                self.loadCandidatesForConstituency(c!)
                
            })
        }
        
        alertController.addTextField { (textField) in
            // placeholder so the user knows what to do...
            textField.placeholder = "Enter postcode"
        }
        
        alertController.addAction(postcodeSearch)

        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func findByConstituencyList(_ sender: UIButton) {
        // check connection...
        if !reachabilityCheck() {
            return
        }
        
        // bit of loading UI...
        SwiftSpinner.show("Loading constituencies", animated: true)
        
        // load ConstituencyTableViewController (after getting constituencies!)
        YourNextMPAPIManager.getConstituencies { (c) -> () in
            // hide loading UI
            SwiftSpinner.hide()
            
            // load it! (via constituenciesListSegue)
            self.constituenciesList = c
            self.performSegue(withIdentifier: "constituenciesListSegue", sender: self)
        }
    }
    
    
    func invalidConstituency() {
        // a generic 'not valid constituency' warning - ask the user to try again in an alert.
        let alertController = UIAlertController(title: "Cannot find constituency", message: "We're sorry but we can't find your constituency. Please try another method of locating it, or choose it from the list instead.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Okay", style: .default, handler: nil)        
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loadCandidatesForConstituency(_ c:Constituency){
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
            self.performSegue(withIdentifier: "candidatesListSegue", sender: self)
            
        })
        
    }

    func reachabilityCheck() -> Bool{
        if Reachability.init()?.currentReachabilityStatus == Reachability.NetworkStatus.notReachable {
            // noo!
            // alert the user and return false...
            let alertController = UIAlertController(title: "No internet connection", message: "We're sorry but this app requires data from the Internet. Please check your Internet connection and try again.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Okay", style: .default, handler: nil)

            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        // must be reachable then...
        return true
    }
    
    @nonobjc func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        // last location is the most recent
        // (typecasting saves all)
        currentLocation = locations.last as! CLLocation
        print("updated location to: " + currentLocation.description)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // grr. not much we can do.
        print("location error: " + error.localizedDescription)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "constituenciesListSegue" {
            // pre-load constituencies in!
            let viewController:ConstituencyTableViewController = segue.destination as! ConstituencyTableViewController
            viewController.constituencyArray = self.constituenciesList
        }
        
        if segue.identifier == "candidatesListSegue" {
            // load candidates in
            let viewController:CandidateTableViewController = segue.destination as! CandidateTableViewController
            viewController.candidateArray = self.candidatesList
        }
    }
    
    
}

