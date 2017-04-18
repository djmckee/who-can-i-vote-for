//
//  String+ContainsExtension.swift
//  who-can-i-vote-for
//
//  Created by Dylan McKee on 31/03/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation

extension String {
    
    // check if the string contains otherString, return accordingly.
    func contains(_ otherString:String!) -> Bool {
        if self.range(of: otherString) != nil{
            return true
        } else {
            return false
        }
    }
    
}
