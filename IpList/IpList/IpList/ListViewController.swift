//
//  ListViewController.swift
//  IpList
//
//  Created by Baid, Arhat Pushparaj on 4/1/18.
//  Copyright © 2018 Baid, Arhat Pushparaj. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var modelIp : ModelIP!
    var arrayIpList = [String]()
    var selectIpAddress : String!
    var alert : UIAlertController!
    var lastCellNumber = 0
    var ipCal = IpCalculator()
    let progressiveLoadingSlot = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadingView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Creating the array list based on the condition
        if (modelIp.maxAddress - modelIp.minAddress)  <= progressiveLoadingSlot{
            for value in modelIp.minAddress...modelIp.maxAddress {
                arrayIpList.append(ipCal.NumberToIp(value))
            }
        }else{
            lastCellNumber = ((modelIp.minAddress + progressiveLoadingSlot) > modelIp.maxAddress) ? modelIp.maxAddress : (modelIp.minAddress + progressiveLoadingSlot)
            for value in modelIp.minAddress...lastCellNumber {
                arrayIpList.append(ipCal.NumberToIp(value))
            }
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "IP List"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrayIpList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Check to see if a reusable cell exists first and use it
        //this will put fewer demands on memory
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell_ip_address", for: indexPath)
        
        cell.textLabel!.text = arrayIpList[indexPath.row]
        
        return cell
        
    }
    
    //Used this func for lazy/progressive loading
    //50 cells will be laoded in a go and as you scroll down another 50 sets of cell will be loaded
    //this avoiding the load on the memory
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row >=  (lastCellNumber - modelIp.minAddress))
        print("Row number: \(indexPath.row) Last Number: \(lastCellNumber - modelIp.minAddress)")
        
        if ((indexPath.row >=  (lastCellNumber - modelIp.minAddress) && (modelIp.maxAddress - modelIp.minAddress)  > progressiveLoadingSlot) && ((lastCellNumber - modelIp.minAddress) % progressiveLoadingSlot == 0)) {

            lastCellNumber = ((lastCellNumber + progressiveLoadingSlot) > modelIp.maxAddress) ? modelIp.maxAddress : (lastCellNumber + progressiveLoadingSlot)
            let startCellNumber = arrayIpList.count + modelIp.minAddress

            for value in startCellNumber...lastCellNumber {
                arrayIpList.append(ipCal.NumberToIp(value))
            }
            
            //after the checks and permission I'm realoding the data into tableview.
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath:IndexPath) {
        selectIpAddress = arrayIpList[indexPath.row]
        self.performSegue(withIdentifier: "sague_detail", sender: self)
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let ipDetailScreen = segue.destination as! IpDetailViewController
        ipDetailScreen.selectIpAddress = selectIpAddress
    }
    
    func loadingView()  {
        alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    func closeLoadingDialog() {
        alert.dismiss(animated: true, completion: nil)
    }
    

}
