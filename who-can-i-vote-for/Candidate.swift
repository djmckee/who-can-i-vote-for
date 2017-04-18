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
class Candidate : Hashable {
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
        let nameComponents:[String] = name.components(separatedBy: " ")
        
        // do some simplistic edge case checking first - this could cause an app crash if it goes wrong... :s
        if nameComponents.count > 1 {
            // they have multiple names, find their last one and return it
            let lastName:String = nameComponents.last!
            return lastName
        } else {
            // they only have one name for some reason - return it and give up.
            return name
        }
    }
    
    init(name:String, party:String){
        self.name = name
        self.party = party
    }
    
    // implementing Hashable protocol (so we can use Sets 'n stuff)
    var hashValue: Int {
        return (name.hashValue ^ party.hashValue)
    }
    
    
}

// and equatable too... (this needs to be OUTSIDE of the class it's comparing which looks ridiculous but is what the documentation states :S )
func == (lhs: Candidate, rhs: Candidate) -> Bool {
    // NOTE: our equality checking here only looks at name and party - this could be VERY DANGEROUS if used to check for nation-wide candidate duplication (since there's probably two candidates with the same name standing for the same party by law of Sod). However, we only ever use this to check for uniqueness on candidates in in individual costituency, where there would never even be more than one candidate standing for each party - so this implementation is fine for our current needs. Maybe in future versions should incoroporate a candidate ID number or something.
    return (lhs.name == rhs.name && rhs.party == rhs.party)
}
