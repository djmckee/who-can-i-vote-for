//
//  Candidate.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation
import UIKit

// A class to model a candidate standing for election.
class Candidate {
    // their name
    let name:String!
    
    // their party
    let party:String!
    
    // compute their colour from party name and return it.
    var colour:UIColor {
        return PartyColours.colourForParty(self.party)
    }
    
    // Compute the last name of the candicate and return it.
    var lastName:String! {
        var fullNameArr = name.componentsSeparatedByString(" ")
        var lastName = fullNameArr[fullNameArr.count - 1]
        return lastName
    }
    
    init(name:String, party:String){
        self.name = name
        self.party = party
    }
    
}