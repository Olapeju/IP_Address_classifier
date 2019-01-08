//
//  Integer.swift
//  IpList
//
//  Created by Baid, Arhat Pushparaj on 4/7/18.
//  Copyright © 2018 Baid, Arhat Pushparaj. All rights reserved.
//

import Foundation

class Integer : CustomStringConvertible {
    
    var integer : Int!
    
    init(_ integer: Int) {
        self.integer = integer
    }
    
    var description : String {
        return String(integer)
    }
}
