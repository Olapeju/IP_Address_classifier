//
//  IpCalculator.swift
//  IpList
//
//  Created by Baid, Arhat Pushparaj on 4/7/18.
//  Copyright © 2018 Baid, Arhat Pushparaj. All rights reserved.
//

import Foundation

class IpCalculator {
    private var ipAddress: String!
    private var subNetmask: String!

    var ipArray = [Int]()
    var baseIPNumeric = 0
    var netmaskNumeric = 0
    var netMask = 0;
    
    private var networkAddress : String!
    private var networkNumber : Int!
    private var numberOfHost  : Int!
    private var hostMinDec : Int!
    private var hostMin : String!
    private var hostMaxDec : Int!
    private var hostMax : String!
    
    
    init(_ ipAddress: String, _ subNetmask: String) {
        self.ipAddress = ipAddress
        self.subNetmask = subNetmask
    }
    
    init() {
    
    }
    
    
    func isIpAddCorrect() -> Bool {
        if (!ipAddress.isEmpty && ipAddress.contains(".")){                 // check if the string conatins "."
            
            ipArray = ipAddress.split(separator: ".").flatMap { Int($0) }           // Form the stringArray and the convrt it to intArray
            if ipArray.count == 4 {             //Check if the array size is 4
                var i = 24;
                baseIPNumeric = 0
                for value in ipArray{
                    if (value < 0 || value > 255) {              // Check for each values of array
                        return false
                    }
                        
                    if (value != (value & 0xff)) {              // Check for each values of array
                        return false
                    }
                    
                    baseIPNumeric = baseIPNumeric + (value << i)
                    i -= 8
                }
                //The Ip address is in the correct form
                return (true)
            }
        }
        return (false)
    }
    
    //checks if the netmask is correct or not
    func isNetMaskCorrect() -> (Bool, Int) {
        if let netMask = Int(subNetmask) {
            if (netMask >= 0 && netMask <= 16) {
                netmaskNumeric = 0xffffffff
                self.netMask = netMask
                netmaskNumeric = netmaskNumeric << (32 - netMask)
                return (true, netMask)
            }
        }
        return (false, -1)
    }
    
    
    
    //called to show the IP range. no of host and other details
    func calculateIpRange() -> String {
        return "Netwrok Address is:  \(networkAddress!)  \nNumber Of Hosts:  \(numberOfHost!)\nMin. Address:  \(hostMin!)\n  Max. Address:  \(hostMax!)"
    }
    
    //All the basic calculation
    func calculateIpAddress()  -> ModelIP{
         networkAddress = getNetworkAddress()
         networkNumber = IpToNumber(networkAddress)
         numberOfHost = getNumberOfHosts()
        if numberOfHost > 0{
            hostMinDec = networkNumber + 1
        }else{
            hostMinDec = networkNumber
        }
        
         hostMin = NumberToIp(hostMinDec)
         hostMaxDec = networkNumber + numberOfHost
         hostMax = NumberToIp(networkNumber + numberOfHost)
        
        return ModelIP(networkAddress!, hostMinDec!, hostMaxDec!, "")
    }
    
    
    func getNetworkAddress() ->String {
        return convertNumericIpToSymbolic(baseIPNumeric & netmaskNumeric)
    }
    
    func convertNumericIpToSymbolic(_ ip: Int) -> String {
        var sb: String! = ""
        var shift = 24;
        while shift > 0 {
            sb.append(String(Integer(Int(Int64(bitPattern: UInt64(Int64(Int(ip))) >> UInt64(Int64(Int(shift))))  & 0xff)).description))
            sb.append(".")
            shift -= 8;
        }
        sb.append(String(Integer(ip & 0xff).description))
        return sb
    }
    
    func getNumberOfHosts() -> Int {
        var x : Int = Int(pow(2, Double(32 - netMask)) - 2)
        
        if x == -1 {
            x = Int(1)
        }
        return Int(x)
    }
    
    
    func IpToNumber(_ ipAddress: String) -> Int {
        let ipArray = ipAddress.split(separator: ".").flatMap { Int($0) }
        var result: Int = 0
        for i in 0..<ipArray.count {
            result = result + ipArray[i] % 256 * Int(pow(Double(256), Double(3 - i)))
        }
        
        return result
    }
    
    
    func NumberToIp(_ ip: Int) -> String {
        return "\(((ip >> 24 ) & 0xFF)).\(((ip >> 16 ) & 0xFF)).\(((ip >> 8 ) & 0xFF)).\((ip & 0xFF))"
    }
    
}
