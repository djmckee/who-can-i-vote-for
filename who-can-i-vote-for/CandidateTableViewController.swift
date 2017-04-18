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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return candidateArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandidateCell", for: indexPath) as! CandidateTableViewCell

        // Configure the cell...
        
        cell.nameLabel?.text = candidateArray[indexPath.row].name
        cell.partyLabel?.text = candidateArray[indexPath.row].party.uppercased()
        cell.contentView.backgroundColor = candidateArray[indexPath.row].colour
        
        //print(candidateArray[indexPath.row].party)
        
        return cell
    }

   
}
