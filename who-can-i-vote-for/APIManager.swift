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
    // declare base url for the API (from https://yournextmp.com/help/api )
    // (they actually only seem to use http:// in the documentation but https:// also appears to work and is nicer so we're gonna use it instead).
    let baseUrl:String! = "https://yournextmp.popit.mysociety.org/api/v0.1/"
    
    class func getConstituencyWithPostcode(postcodeString: String!) -> Constituency! {
        // concatenate our URL together.
        let urlString = "https://mapit.mysociety.org/postcode/" + postcodeString
        
        var id:Int!
        
        // perform request...
        request(Method.GET, urlString, parameters: nil, encoding: ParameterEncoding.URL).responseJSON { (request, response, data, error) -> Void in
            //println(data)
        
            if (data != nil) {
                // have data - yay.
                // check for error codes...
                
                var dict:Dictionary<String, AnyObject>!
                
                dict = data as Dictionary<String, AnyObject>
                
                if (dict["code"] != nil) {
                    println("error code present!")
                    id = -1
                } else {
                    println("success")
                    // no error codes - get parsing...
                    let shortcuts:Dictionary<String, AnyObject>! = dict["shortcuts"] as Dictionary<String, AnyObject>
                    // typecasting makes it all okay...
                    var wmc:Int = shortcuts["WMC"] as Int
                    // id is now whatever we've retrieved it to be
                    id = wmc
                    
                }
            }
            
        }
        
        // return a Constituency with an id of whatever we've parsed...
        return Constituency(constituencyId: id)

    }
    
    class func getConstituencyWithCoordinate(coordinate : CLLocationCoordinate2D!) -> Constituency! {
        // concatenate our URL together.
        let latitude:Double = coordinate.latitude as Double
        let longitude:Double = coordinate.longitude as Double
        
        // NOTE: Longitude comes BEFORE Latitude for this API (unlike anything else in existance ever).
        let urlString = String(format: "https://mapit.mysociety.org/point/4326/%f,%f?type=WMC", longitude, latitude)
        println("urlString: " + urlString)
        
        var id:Int!
        
        // perform request...
        request(Method.GET, urlString, parameters: nil, encoding: ParameterEncoding.URL).responseJSON { (request, response, data, error) -> Void in
            println("Data: ")
            println(data)
            
            if (data != nil) {
                // have data - yay.
                // check for error codes...
                
                var dict:Dictionary<String, AnyObject>!
                
                dict = data as Dictionary<String, AnyObject>
                
                if (dict["code"] != nil) {
                    println("error code present!")
                    id = -1
                } else {
                    println("success")
                    // okay, the key is the ID, apparently...
                    var idNumberStringRepresentation:String! = dict.keys.array[0]
                    
                    // do a quick conversion...
                    id = idNumberStringRepresentation.toInt()
                    
                }
            }
            
        }
        
        // return a Constituency with an id of whatever we've parsed...
        return Constituency(constituencyId: id)
    }
    
}