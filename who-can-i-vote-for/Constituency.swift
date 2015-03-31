//
//  Constituency.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation

// A model class to represent a UK parlimentary Constituency
class Constituency {
    // the ID number of the Constituency when used within the YourNextMP API
    let idNumber:Int!
    
    init(constituencyId:Int!){
        // set up our ID to whatever we've been passed...
        idNumber = constituencyId
    }
    
}