//
//  PartyColours.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation
import UIKit

var theme = "flat"

// some constant political party colours... (cool colours from http://flatuicolors.com/ )
class PartyColours {
    
    
    class func colourForParty(partyName :String!) -> UIColor {        
        if partyName.contains("Labour Party") {
            // Labour Red
            if theme == "flat" {
                return UIColor(red: (179.0000/255.0), green: (36.0000/255.0), blue: (28.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (178.0000/255.0), green: (34.0000/255.0), blue: (34.0000/255.0), alpha: (1.0000))
            }
        } else if partyName.contains("Conservative Party") {
            // Tory Blue
            if theme == "flat" {
                return UIColor(red: (29.0000/255.0), green: (106.0000/255.0), blue: (173.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (0.0000/255.0), green: (135.0000/255.0), blue: (220.0000/255.0), alpha: (1.0000))
            }
        } else if partyName.contains("Green Party") {
            // Green Party Green
            if theme == "flat" {
                return UIColor(red: (30.0000/255.0), green: (164.0000/255.0), blue: (75.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (106.0000/255.0), green: (176.0000/255.0), blue: (35/255.0), alpha: (1.0000))
            }
        } else if partyName.contains("UK Independence Party"){
            // UKIP Purple
            if theme == "flat" {
                return UIColor(red: (123.0000/255.0), green: (38.0000/255.0), blue: (159.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (112/255), green: (20/255), blue: (122/255), alpha: 1)
            }
        } else if partyName.contains("Scottish National Party") {
            // SNP Yellow
            if theme == "flat" {
                return UIColor(red: (207.0/255.0), green: (202.0/255.0), blue: (24.0/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: 1, green: 1, blue: 0, alpha: 1)
            }
        } else if partyName.contains("Plaid Cymru") {
            // A darkish green.
            if theme == "flat" {
                return UIColor(red: (50.0000/255.0), green: (116.0000/255.0), blue: (30.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: 0, green: (129/255), blue: (66/255), alpha: 1)
            }
        } else if partyName.contains("Liberal Democrats"){
            // Lib dem yellow.
            if theme == "flat" {
                return UIColor(red: (238.0000/255.0), green: (187.0000/255.0), blue: (0.0000/255.0), alpha: (1.0000))
            } else {
                return UIColor(red: (253/255.0), green: (187.0000/255.0), blue: (48.0000/255.0), alpha: (1.0000))
            }
        } else if partyName.contains("Independent") {
            // Indep grey
            if theme == "flat" {
                return UIColor(red: (149/255), green: (165/255), blue: (166/255), alpha: (1.0))
            } else {
                return UIColor(red: (221/255), green: (221/255), blue: (221/255), alpha: (1.0))
            }
        } else if partyName.contains("British National Party") {
            // BNP Black
            if theme == "flat" {
                return UIColor(red: (12/255), green: (12/255), blue: (12/255), alpha: (1.0))
            } else {
                return UIColor(red: (1), green: (1), blue: (139/255), alpha: (1.0))
            }
        } else {
            // a nice neuteral turquoise-ish.
            return UIColor(red: (21.0000/255.0), green: (178.0000/255.0), blue: (138.0000/255.0), alpha: (1.0000))
        }
    }
}