//
//  IpDetailViewController.swift
//  IpList
//
//  Created by Baid, Arhat Pushparaj on 4/1/18.
//  Copyright © 2018 Baid, Arhat Pushparaj. All rights reserved.
//

import UIKit

class IpDetailViewController: UIViewController {

    var selectIpAddress : String!
    var isModifyClicked = false
    
    @IBOutlet weak var txtClass: UILabel!
     @IBOutlet weak var txtAddress: UILabel!
    
    @IBAction func btnModify(_ sender: UIButton) {
        isModifyClicked = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtAddress!.text = selectIpAddress
        var networkClass: String!
        let value = selectIpAddress.split(separator: ".").flatMap { Int($0) }[0]
        switch value {
        case 1...127:
            networkClass = "A"
        case 128...191:
            networkClass = "B"
        case 192...223:
            networkClass = "C"
        case 224...239:
            networkClass = "D"
        case 240...255:
            networkClass = "E"
        default:
            networkClass = "N/A"
        }
        
        txtClass!.text =  "Class " + networkClass
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let homeScreen = segue.destination as! HomeViewController
        homeScreen.isModifyClicked = isModifyClicked
    }
    

}
