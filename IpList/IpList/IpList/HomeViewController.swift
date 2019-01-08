//
//  ViewController.swift
//  IpList
//
//  Created by Baid, Arhat Pushparaj on 4/1/18.
//  Copyright © 2018 Baid, Arhat Pushparaj. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var txtIpAddress: UITextField!
    @IBOutlet weak var txtNetMask: UITextField!
    
    var ipCalc: IpCalculator!
    var modelIp : ModelIP!
    var isModifyClicked : Bool!
    
    @IBAction func btnMinMaxIp(_ sender: UIButton) {
        ipCalc = IpCalculator(txtIpAddress.text!, txtNetMask.text!)

        if !ipCalc.isIpAddCorrect() {
            showAlert(title: "Error", msg: "The enter Ip is not correct!!!")
            return
        }
        
        if !ipCalc.isNetMaskCorrect().0 {
            showAlert(title: "Error", msg: "The nextmask value should be btween 1 -16")
            return
        }
        
        //Calculate the ip address as the inputs are correct.
        modelIp = ipCalc.calculateIpAddress()
        showAlert(title: "IP Address Details", msg: " \(ipCalc.calculateIpRange())")    
    }
    
    
    @IBAction func btnAllIp(_ sender: UIButton) {
        ipCalc = IpCalculator(txtIpAddress.text!, txtNetMask.text!)
        
        if !ipCalc.isIpAddCorrect() {
            showAlert(title: "Error", msg: "The enter Ip is not correct!!!")
            return
        }
        
        if !ipCalc.isNetMaskCorrect().0 {
            showAlert(title: "Error", msg: "The nextmask value should be btween 1 -16")
            return
        }
        
       modelIp = ipCalc.calculateIpAddress()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Init the views and keyboards
        initViews();
    }
    
    func initViews()  {
        self.txtIpAddress.delegate =  self
        self.txtNetMask.delegate =  self
        txtIpAddress.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtNetMask.resignFirstResponder()
        txtIpAddress.resignFirstResponder()
        view.endEditing(true)
    }
    
    func showAlert(title: String, msg: String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listScreen = segue.destination as! ListViewController
        listScreen.modelIp = modelIp
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        //Clear the text fields if the modift button is clicked
        if isModifyClicked {
            txtIpAddress.text = ""
            txtNetMask.text = ""
        }
    }
    


}

