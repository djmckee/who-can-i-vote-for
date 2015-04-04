//
//  ConstituencyTableViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 03/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class ConstituencyTableViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var searchBar:UISearchBar?
    
    var isSearching:Bool = false
    
    var constituencyArray:Array<Constituency>! = []
    var candidatesList:Array<Candidate>! = []
    var searchingArray:Array<Constituency>! = []


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Constituencies"


        // very cunning search bar cancel button  colour reset trick from http://stackoverflow.com/questions/2787481/uisearchbar-cancel-button-color
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        finishSearching()
        
        super.viewWillDisappear(animated)
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if isSearching {
            return searchingArray.count
        }
        
        return constituencyArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ConstituencyCell", forIndexPath: indexPath) as ConstituencyTableViewCell

        // Configure the cell...
        
        if isSearching {
            cell.constituencyLabel?.text = searchingArray[indexPath.row].name

        } else {
            cell.constituencyLabel?.text = constituencyArray[indexPath.row].name

        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // de-select!
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // get tapped constituency...
        var chosen:Constituency
        
        if isSearching {
            chosen = searchingArray[indexPath.row]
        } else {
            chosen = constituencyArray[indexPath.row]
        }
        
        //println("chosen " + chosen.name)
        
        // get candidates... update loading UI too
        SwiftSpinner.show("Finding candidates", animated: true)
        
        
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
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        isSearching = true
        searchBar.showsCancelButton = true

        tableView?.reloadData()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        isSearching = false
        searchBar.showsCancelButton = false

    }
    
    func finishSearching() {
        isSearching = false
        searchBar?.showsCancelButton = false
        searchBar?.text = ""
        
        searchBar?.resignFirstResponder()
        
        // and reload our table...
        tableView?.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        finishSearching()

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        isSearching = true
        searchBar.showsCancelButton = true
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // filter results to what's contained within the array that matches seach terms...
        searchingArray = constituencyArray.filter({ (c) -> Bool in
            let nameString:NSString = NSString(string: c.name)
            let range = nameString.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        // re-sort to ensure alphabetic arrangement is maintained.
        searchingArray = searchingArray.sorted({ $0.name < $1.name})
        
        // and reload our table...
        tableView?.reloadData()
        
        searchBar.showsCancelButton = true

    }

}
