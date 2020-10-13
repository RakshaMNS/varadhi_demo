//
//  ViewController.swift
//  VaradhiDemo
//
//  Created by mns on 12/10/20.
//  Copyright © 2020 mns. All rights reserved.
//

import UIKit

class MonthlyAppointmentVC: UIViewController {
    
    @IBOutlet weak var montlyDetailsTV: UITableView!
    
    @IBOutlet weak var noDataLabel: UILabel!{
        didSet{
            noDataLabel.isHidden = true
        }
    }
    
    var monthlyAppointmentDetails = [AppointmentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reachability =  Reachability()
        if let _ = reachability?.isReachable{
            APIServices().getAppointmentMonthlyDetails(){(details, response, error) in
                if let details = details{
                    DispatchQueue.main.async {
                        self.noDataLabel.isHidden = true
                        self.monthlyAppointmentDetails = details.unassigned ?? []
                        self.montlyDetailsTV.reloadData()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.monthlyAppointmentDetails =  []
                        self.montlyDetailsTV.reloadData()
                        self.noDataLabel.text = "Something went wrong"
                        self.noDataLabel.isHidden = false
                    }
                }
            }
        }else{
            self.noDataLabel.text = "No Network"
            self.noDataLabel.isHidden = false
        }
    }
}

extension MonthlyAppointmentVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyAppointmentDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as? DataTableViewCell{
            tableCell.configureCell(data: monthlyAppointmentDetails[indexPath.row])
            return tableCell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(apiKey != ""){
            let data = monthlyAppointmentDetails[indexPath.row]
            if let mapDetVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapDetailsVC") as? MapDetailsVC{
                mapDetVC.addressDetails = data
                self.present(mapDetVC, animated: true, completion: nil)
            }
        }
    }
    
}

