//
//  ModelIP.swift
//  IpList
//
//  Created by Baid, Arhat Pushparaj on 4/7/18.
//  Copyright © 2018 Baid, Arhat Pushparaj. All rights reserved.
//

import Foundation

class ModelIP {
    var networkAddress: String
    var selectedAddress: String
    var minAddress: Int
    var maxAddress: Int
    
    init(_ networkAddress: String, _ minAddress: Int, _ maxAddress: Int, _ selectedAddress: String) {
        self.networkAddress = networkAddress
        self.minAddress = minAddress
        self.maxAddress = maxAddress
        self.selectedAddress = selectedAddress
    }
}
