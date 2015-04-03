//
//  CandidateTableViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 03/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class CandidateTableViewController: UITableViewController {
    
    var candidateArray:Array<Candidate> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Candidates"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CandidateCell", forIndexPath: indexPath) as CandidateTableViewCell

        // Configure the cell...
        
        cell.nameLabel?.text = candidateArray[indexPath.row].name
        cell.partyLabel?.text = candidateArray[indexPath.row].party
        cell.backgroundColor = candidateArray[indexPath.row].colour

        
        return cell
    }

   
}
