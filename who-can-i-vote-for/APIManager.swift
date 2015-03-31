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
    
    class func getConstituencies() -> Array<Constituency> {
        // construct a blank mutable array...
        var array:Array<Constituency> = Array<Constituency>()
        
        let urlString = "http://mapit.mysociety.org/areas/WMC"
        
        // perform request...
        request(Method.GET, urlString, parameters: nil, encoding: ParameterEncoding.URL).responseJSON { (request, response, data, error) -> Void in
            //println("Data: ")
            //println(data)
            // data is a huge dictionary, where keys are id's, objects are dictionaries - these dictionaries contain a key "name" - a human readable name string...
            let dataSet:Dictionary<String, Dictionary<String, AnyObject>> = data as Dictionary<String, Dictionary<String, AnyObject>>
            
            let dataKeys:Array<String> = dataSet.keys.array;
            
            // lol, range literals to the extreme... (subtracting 1 to avoid off by one!!)
            for i in 0...(dataKeys.count - 1) {
                // get ID from the key...
                var constituencyId:Int = dataKeys[i].toInt()!
                
                // get associated name info from the object dict's "name" key...
                var constituencyName:String = dataSet.values.array[i]["name"] as String
                
                // instanciate our Constituency
                var constituency:Constituency = Constituency(constituencyId: constituencyId)
                
                // set name too since we have one in this case...
                constituency.name = constituencyName
                
                // and add it to our array...
                array.append(constituency)
                
                println("Adding " + constituencyName)
            }

            
        }

        
        // return our array now that it's full...
        return array;
    }
    
    
}