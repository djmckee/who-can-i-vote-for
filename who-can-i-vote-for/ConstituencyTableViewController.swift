//
//  ConstituencyTableViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 03/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class ConstituencyTableViewController: UIViewController {

    var constituencyArray:Array<Constituency> = []

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
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
