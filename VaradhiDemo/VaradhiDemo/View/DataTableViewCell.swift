//
//  DataTableViewCell.swift
//  VaradhiDemo
//
//  Created by mns on 12/10/20.
//  Copyright © 2020 mns. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var institutionNameLabel: UILabel!
    @IBOutlet weak var pocNameLabel: UILabel!
    @IBOutlet weak var employeedIdLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data : AppointmentModel){
        institutionNameLabel.text = "Institution Name: " + (data.Institution_Name ?? "")
        pocNameLabel.text = "POC Name: " + (data.POC_Name ?? "")
        employeedIdLabel.text = "Employee Id: " + (data.marketing_user_employee_id ?? "")

    }
    
    @IBAction func mapButtonAction(_ sender: UIButton) {

    }

}
