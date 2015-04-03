//
//  YourNextMPAPIManager.swift
//  who-can-i-vote-for
//  A Swift API wrapper for the YourNextMP.com API
//  (all data/endpoints provided by https://yournextmp.com/help/api )
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation
import CoreLocation

class YourNextMPAPIManager {

    class func getConstituencyWithPostcode(postcodeString: String!, completionHandler: (Constituency?) -> ()) -> Void {
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
                    completionHandler(Constituency(constituencyId: id))

                } else {
                    //println("success")
                    // no error codes - get parsing...
                    let shortcuts:Dictionary<String, AnyObject>! = dict["shortcuts"] as Dictionary<String, AnyObject>
                    // typecasting makes it all okay...
                    var wmc:Int = shortcuts["WMC"] as Int
                    // id is now whatever we've retrieved it to be
                    id = wmc
                    
                }
            }
            
            // return a Constituency with an id of whatever we've parsed to the completion handler...
            completionHandler(Constituency(constituencyId: id))

        }
        

    }
    
    class func getConstituencyWithCoordinate(coordinate : CLLocationCoordinate2D!, completionHandler: (Constituency?) -> ()) -> Void {
        // concatenate our URL together.
        let latitude:Double = coordinate.latitude as Double
        let longitude:Double = coordinate.longitude as Double
        
        // NOTE: Longitude comes BEFORE Latitude for this API (unlike anything else in existance ever).
        let urlString = String(format: "https://mapit.mysociety.org/point/4326/%f,%f?type=WMC", longitude, latitude)
        
        var id:Int!
        
        // perform request...
        request(Method.GET, urlString, parameters: nil, encoding: ParameterEncoding.URL).responseJSON { (request, response, data, error) -> Void in
            
            if (data != nil) {
                // have data - yay.
                // check for error codes...
                
                var dict:Dictionary<String, AnyObject>!
                
                dict = data as Dictionary<String, AnyObject>
                
                if (dict["code"] != nil) {
                    println("error code present!")
                    id = -1
                    completionHandler(Constituency(constituencyId: id))

                } else {
                    //println("success")
                    // okay, the key is the ID, apparently...
                    var idNumberStringRepresentation:String! = dict.keys.array[0]
                    //println("idNumberStringRepresentation = " + idNumberStringRepresentation)
                    // do a quick conversion...
                    id = idNumberStringRepresentation.toInt()
                    
                }
        
                // return a Constituency with an id of whatever we've parsed...
                completionHandler(Constituency(constituencyId: id))
            }
            
        }
        
    }
    
    class func getConstituencies(completionHandler: (Array<Constituency>?) -> ()) -> Void {
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
            
            for key in dataKeys {
                // get ID from the key...
                var constituencyId:Int = key.toInt()!
                
                // get associated name info from the object dict's "name" key...
                var dict:Dictionary<String, AnyObject> = dataSet[key]!
                var constituencyName:String = dict["name"] as String
                
                // instanciate our Constituency
                var constituency:Constituency = Constituency(constituencyId: constituencyId)
                
                // set name too since we have one in this case...
                constituency.name = constituencyName
                
                // and add it to our array...
                array.append(constituency)
                
                //println("Adding " + constituencyName)
            }
            
            // sort the array alphabetically
            array = array.sorted({ $0.name < $1.name})

            // return to the completion handler...
            completionHandler(array)
        }

    }
    
    class func getCandidatesInConstituency(constituency: Constituency, completionHandler: (Array<Candidate>?) -> ()) -> Void {
        // construct a blank mutable array...
        var array:Array<Candidate> = Array<Candidate>()
        
        // formulate our URL...
        let urlString:String = String(format: "https://yournextmp.popit.mysociety.org/api/v0.1/posts/%d?embed=membership.person", constituency.idNumber)

        // perform request...
        request(Method.GET, urlString, parameters: nil, encoding: ParameterEncoding.URL).responseJSON { (request, response, data, error) -> Void in
            //println("Data: ")
            //println(data)
            
            var standingCandidates:Array<Dictionary<String, AnyObject>> = Array<Dictionary<String, AnyObject>>();
            
            var dataDict:Dictionary<String, AnyObject> = data as Dictionary<String, AnyObject>
            var results = dataDict["result"] as Dictionary<String, AnyObject>
            var memberships = results["memberships"] as Array<Dictionary<String, AnyObject>>

            
            for member in memberships {
                var personInfo = member["person_id"] as Dictionary<String, AnyObject>
                var standing: AnyObject? = personInfo["standing_in"]
                var standingDict:NSDictionary = standing as NSDictionary
                if (standingDict.objectForKey("2015") != nil) {
                    // also check for <null> strings, grrrr....
                    var standingDetails: AnyObject? = standingDict.objectForKey("2015")
                    if (standingDetails as? NSNull != nil){
                        //println("should not be including " + member.description)
                        continue
                    }
                    
                    // check it's the right constituency too!
                    var c = standingDetails?.objectForKey("post_id") as NSString
                    
                    if c.integerValue != constituency.idNumber {
                        // they're not standing in our constituency for this election... ignore them!
                        continue
                    }
                    
                    // they're standing this year!
                    // let's instanciate a candidate object for them, and add relevant information...
                    var name = personInfo["name"] as String
                    var partyMemberships = personInfo["party_memberships"] as NSDictionary
                    var partyName = partyMemberships.objectForKey("2015")?.objectForKey("name") as NSString
                    var candidate:Candidate = Candidate(name: name, party: partyName)

                    array.append(candidate)
                }
            }
            
            // grr, duplicates seem to be an issue...
            var uniques:Array<Candidate> = Array<Candidate>();
            
            // loop through each candidate checking uniqes doesn't already contain someone with their party - two candidates cannot stand for the same party in one consituency (right...)
            for c:Candidate in array {

                var shouldAdd:Bool = true;
                
                for x:Candidate in uniques {
                    // is x's party equal to c's party?
                    // (wow swift's string equality checking syntax is lovely).
                    if x.party == c.party {
                        // DO NOT allow more than one candidate for each party in the constituency...
                        shouldAdd = false;
                    }
                }
                // we've finished checking EVERY exisiting unique candidate, so we'll know if we can safely add...
                if shouldAdd {
                    uniques.append(c)
                }
            }
            
            // set our array to be the unique array...
            array = uniques
            
            // okay, now we're gonna sort the array alphabetically to be fair (just by first name, keeping things sensible)...
            array = array.sorted({ $0.name < $1.name})
            
            // return to the completion handler...
            completionHandler(array)
        }

    }
    
}