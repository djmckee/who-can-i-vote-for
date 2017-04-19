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
import Alamofire

class YourNextMPAPIManager {

    class func getConstituencyWithPostcode(_ postcodeString: String!, completionHandler: @escaping (Constituency?) -> ()) -> Void {
        // concatenate our URL together.
        let urlString = "https://mapit.mysociety.org/postcode/" + postcodeString
        
        var id:Int!
        
        // perform request...
        request(urlString, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response.request ?? "No HTTP request? wtf.")  // original URL request
            print(response.response ?? "No HTTP response") // HTTP URL response
            print(response.data ?? "No data")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                
            }
        
            /*
            if (data != nil) {
                // have data - yay.
                // check for error codes...
                
                var dict:Dictionary<String, AnyObject>!
                
                dict = data as! Dictionary<String, AnyObject>
                
                if (dict["code"] != nil) {
                    print("error code present!")
                    id = -1
                    completionHandler(Constituency(constituencyId: id))

                } else {
                    //print("success")
                    // no error codes - get parsing...
                    let shortcuts:Dictionary<String, AnyObject>! = dict["shortcuts"]as! Dictionary<String, AnyObject>
                    // typecasting makes it all okay...
                    var wmc:Int = shortcuts["WMC"] as! Int
                    // id is now whatever we've retrieved it to be
                    id = wmc
                    
                }
            }
            
            // return a Constituency with an id of whatever we've parsed to the completion handler...
            completionHandler(Constituency(constituencyId: id))

 */
        }
 
        

    }
    
    class func getConstituencyWithCoordinate(_ coordinate : CLLocationCoordinate2D!, completionHandler: @escaping (Constituency?) -> ()) -> Void {
        // concatenate our URL together.
        let latitude:Double = coordinate.latitude as Double
        let longitude:Double = coordinate.longitude as Double
        
        // NOTE: Longitude comes BEFORE Latitude for this API (unlike anything else in existance ever).
        let urlString = String(format: "https://mapit.mysociety.org/point/4326/%f,%f?type=WMC", longitude, latitude)
        
        var id:Int!
        
        // perform request...
        request(urlString, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response.request ?? "No HTTP request? wtf.")  // original URL request
            print(response.response ?? "No HTTP response") // HTTP URL response
            print(response.data ?? "No data")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                
            }
            
            /*
            if (data != nil) {
                // have data - yay.
                // check for error codes...
                
                var dict:Dictionary<String, AnyObject>!
                
                dict = data as! Dictionary<String, AnyObject>
                
                if (dict["code"] != nil) {
                    print("error code present!")
                    id = -1
                    completionHandler(Constituency(constituencyId: id))

                } else {
                    //print("success")
                    // okay, the key is the ID, apparently...
                    var idNumberStringRepresentation:String! = dict.keys.first!
                    //print("idNumberStringRepresentation = " + idNumberStringRepresentation)
                    // do a quick conversion...
                    id = Int(idNumberStringRepresentation)
                    
                }
        
                // return a Constituency with an id of whatever we've parsed...
                completionHandler(Constituency(constituencyId: id))
            }*/
            
        }
        
    }
    
    class func getConstituencies(_ completionHandler: @escaping (Array<Constituency>?) -> ()) -> Void {
        // construct a blank mutable array...
        var array:Array<Constituency> = Array<Constituency>()
        
        let urlString = "http://mapit.mysociety.org/areas/WMC"
        
        // perform request...
        request(urlString, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response.request ?? "No HTTP request? wtf.")  // original URL request
            print(response.response ?? "No HTTP response") // HTTP URL response
            print(response.data ?? "No data")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                // data is a huge dictionary, where keys are id's, objects are dictionaries - these dictionaries contain a key "name" - a human readable name string...
                print("JSON: \(JSON)")
                let dataSet:Dictionary<String, Dictionary<String, AnyObject>> = JSON as! Dictionary<String, Dictionary<String, AnyObject>>
                
                let dataKeys = dataSet.keys
                
                for key in dataKeys {
                    // get ID from the key...
                    let constituencyId:Int = Int(key)!
                    
                    // get associated name info from the object dict's "name" key...
                    var dict:Dictionary<String, AnyObject> = dataSet[key]!
                    let constituencyName:String = dict["name"] as! String
                    
                    // instanciate our Constituency
                    let constituency:Constituency = Constituency(constituencyId: constituencyId)
                    
                    // set name too since we have one in this case...
                    constituency.name = constituencyName
                    
                    // and add it to our array...
                    array.append(constituency)
                    
                    print("Adding " + constituencyName)
                }
                
                // sort the array alphabetically
                array = array.sorted(by: { $0.name < $1.name})
                
                // return to the completion handler...
                completionHandler(array)


            }
            
            
        }
 

    }
    
    class func getCandidatesInConstituency(_ constituency: Constituency, completionHandler: @escaping (Array<Candidate>?) -> ()) -> Void {
        // construct a blank mutable array...
        var array:Array<Candidate> = Array<Candidate>()
        
        // formulate our URL...
        let urlString:String = String(format: "https://yournextmp.popit.mysociety.org/api/v0.1/posts/%d?embed=membership.person", constituency.idNumber)

        // perform request...
        request(urlString, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response.request ?? "No HTTP request? wtf.")  // original URL request
            print(response.response ?? "No HTTP response") // HTTP URL response
            print(response.data ?? "No data")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                
            }
            
            /*
            
            var standingCandidates:Array<Dictionary<String, AnyObject>> = Array<Dictionary<String, AnyObject>>()
            
            var dataDict:Dictionary<String, AnyObject> = data as! Dictionary<String, AnyObject>
            var results = dataDict["result"] as! Dictionary<String, AnyObject>
            var memberships = results["memberships"] as! Array<Dictionary<String, AnyObject>>

            
            for member in memberships {
                var personInfo = member["person_id"] as! Dictionary<String, AnyObject>
                var standing: AnyObject? = personInfo["standing_in"]
                var standingDict:NSDictionary = standing as! NSDictionary
                if (standingDict.object(forKey: "2015") != nil) {
                    // also check for <null> strings, grrrr....
                    var standingDetails: AnyObject? = standingDict.object(forKey: "2015") as AnyObject
                    if (standingDetails as? NSNull != nil){
                        //print("should not be including " + member.description)
                        continue
                    }
                    
                    // check it's the right constituency too!
                    var c = standingDetails?.object("post_id") as! NSString
                    
                    if c.integerValue != constituency.idNumber {
                        // they're not standing in our constituency for this election... ignore them!
                        continue
                    }
                    
                    // they're standing this year!
                    // let's instanciate a candidate object for them, and add relevant information...
                    var name = personInfo["name"] as! String
                    var partyMemberships = personInfo["party_memberships"] as! NSDictionary
                    var partyName = (partyMemberships.object(forKey: "2017") as AnyObject).object("name") as! NSString
                    var candidate:Candidate = Candidate(name: name, party: partyName as String)

                    array.append(candidate)
                }
            }
            
            // grr, duplicates seem to be an issue...
            var uniques:Set<Candidate> = Set<Candidate>();
            
            // add all candidates to the set - by definiition, sets do not allow duplicates - so the set will contain only uniques (thanks to the fact that the Candidate class implements Hashable/Equatable protocols)
            for c in array {
                uniques.insert(c)
            }
        
            // construct an array from the set of uniques and make that our array...
            array = Array<Candidate>(uniques)
            
            // okay, now we're gonna sort the array alphabetically to be fair (just by last name, keeping things sensible)...
            
            array = array.sorted(by: { $0.lastName < $1.lastName })
            
            // return to the completion handler...
            completionHandler(array)
 
 */
            
        }

    }
    
}
