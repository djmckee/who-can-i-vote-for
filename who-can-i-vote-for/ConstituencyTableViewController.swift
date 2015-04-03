//
//  ConstituencyTableViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 03/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class ConstituencyTableViewController: UIViewController {

    //TODO: Make list searchable
    
    var constituencyArray:Array<Constituency> = []
    var candidatesList:Array<Candidate>! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Constituencies"


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return constituencyArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ConstituencyCell", forIndexPath: indexPath) as ConstituencyTableViewCell

        // Configure the cell...

        cell.constituencyLabel?.text = constituencyArray[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // get tapped constituency...
        let chosen:Constituency = constituencyArray[indexPath.row]
        println("chosen " + chosen.name)
        
        // get candidates... update loading UI too
        SwiftSpinner.show("Finding candidates")
        
        
        YourNextMPAPIManager.getCandidatesInConstituency(chosen, completionHandler: { (candidates) -> () in
            // load a candidate list!
            SwiftSpinner.hide()
            
            self.candidatesList = candidates
            self.performSegueWithIdentifier("constituencyCandidateSegue", sender: self)
            
        })
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "constituencyCandidateSegue" {
            // load candidates in
            var viewController:CandidateTableViewController = segue.destinationViewController as CandidateTableViewController
            viewController.candidateArray = self.candidatesList
        }
    }

}
