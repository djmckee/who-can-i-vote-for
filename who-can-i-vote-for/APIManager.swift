//
//  APIManager.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation
import CoreLocation

class APIManager {
    // declare base url for the API (from https://yournextmp.com/help/api)
    // (they actually only seem to use http:// in the documentation but https:// also appears to work and is nicer so we're gonna use it instead).
    let baseUrl:String! = "https://yournextmp.popit.mysociety.org/api/v0.1/"
    
    func getConstituencyWithPostcode(postcodeString: String!) -> NSDictionary! {
        
        return NSDictionary()
    }
    
    func getConstituencyWithCoordinate(coordinate : CLLocationCoordinate2D!) -> NSDictionary! {
        
        return NSDictionary()
    }
    
}