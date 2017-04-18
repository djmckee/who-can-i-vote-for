//
//  ConstituencyTableViewController.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 03/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit
import SwiftSpinner
import ReachabilitySwift

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
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: UIControlState())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        finishSearching()
        
        super.viewWillDisappear(animated)
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if isSearching {
            return searchingArray.count
        }
        
        return constituencyArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConstituencyCell", for: indexPath) as! ConstituencyTableViewCell

        // Configure the cell...
        
        if isSearching {
            cell.constituencyLabel?.text = searchingArray[indexPath.row].name

        } else {
            cell.constituencyLabel?.text = constituencyArray[indexPath.row].name

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        // de-select!
        tableView.deselectRow(at: indexPath, animated: true)
        
        // get tapped constituency...
        var chosen:Constituency
        
        if isSearching {
            chosen = searchingArray[indexPath.row]
        } else {
            chosen = constituencyArray[indexPath.row]
        }
        
        //print("chosen " + chosen.name)
        
        // get candidates... update loading UI too
        SwiftSpinner.show("Finding candidates", animated: true)
        
        
        YourNextMPAPIManager.getCandidatesInConstituency(chosen, completionHandler: { (candidates) -> () in
            // load a candidate list!
            SwiftSpinner.hide()
            
            self.candidatesList = candidates
            self.performSegue(withIdentifier: "constituencyCandidateSegue", sender: self)
            
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "constituencyCandidateSegue" {
            // load candidates in
            let viewController:CandidateTableViewController = segue.destination as! CandidateTableViewController
            viewController.candidateArray = self.candidatesList
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        searchBar.showsCancelButton = true

        tableView?.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        finishSearching()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
        searchBar.showsCancelButton = true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // filter results to what's contained within the array that matches seach terms...
        searchingArray = constituencyArray.filter({ (c) -> Bool in
            let nameString:NSString = NSString(string: c.name)
            let range = nameString.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        // re-sort to ensure alphabetic arrangement is maintained.
        searchingArray = searchingArray.sorted(by: { $0.name < $1.name})
        
        // and reload our table...
        tableView?.reloadData()
        
        searchBar.showsCancelButton = true

    }

}
