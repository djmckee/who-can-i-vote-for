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
    
}