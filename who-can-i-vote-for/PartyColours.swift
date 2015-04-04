//
//  PartyColours.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation
import UIKit

// some constant political party colours... (cool colours from http://flatuicolors.com/ )
class PartyColours {
    
    
    class func colourForParty(partyName :String!) -> UIColor {        
        if partyName.contains("Labour Party") {
            // Labour red
            return UIColor(red: (179.0000/255.0), green: (36.0000/255.0), blue: (28.0000/255.0), alpha: (1.0000))
        } else if partyName.contains("Conservative Party") {
            // Tory blue
            return UIColor(red: (29.0000/255.0), green: (106.0000/255.0), blue: (173.0000/255.0), alpha: (1.0000))
        } else if partyName.contains("Green Party") {
            // Green green
            return UIColor(red: (30.0000/255.0), green: (164.0000/255.0), blue: (75.0000/255.0), alpha: (1.0000))
        } else if partyName.contains("UK Independence Party"){
            // purple.
            return UIColor(red: (123.0000/255.0), green: (38.0000/255.0), blue: (159.0000/255.0), alpha: (1.0000))
        } else if partyName.contains("Scottish National Party") {
            // A light ish yellow
            return UIColor(red: (244.0/255.0), green: (208.0/255.0), blue: (63.0/255.0), alpha: (1.0000))
        } else if partyName.contains("Plaid Cymru") {
            // A darkish green.
            return UIColor(red: (50.0000/255.0), green: (116.0000/255.0), blue: (30.0000/255.0), alpha: (1.0000))
        } else if partyName.contains("Liberal Democrats"){
            // Lib dem yellow.
            return UIColor(red: (238.0000/255.0), green: (187.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
        }else {
            // a nice neuteral turquoise-ish.
            return UIColor(red: (21.0000/255.0), green: (178.0000/255.0), blue: (138.0000/255.0), alpha: (1.0000))
        }
    }
}