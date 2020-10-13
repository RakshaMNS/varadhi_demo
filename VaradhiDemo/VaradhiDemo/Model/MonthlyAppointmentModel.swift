//
//  MonthlyAppointmentModel.swift
//  VaradhiDemo

//  Created by mns on 12/10/20.
//  Copyright © 2020 mns. All rights reserved.

import Foundation

struct AppointModel: Codable{
    var status: String?
    var unassigned: [AppointmentModel]?
    var message: String?
    var status_code : Int?
    var assigned : [AssignedModel]?
    
}

struct AppointmentModel : Codable{
    var POC_Email : String?
    var Address_Line_2 : String?
    var Address_Line_1 : String?
    var City : String?
    var Land_Mark : String?
    var PIN : Int?
    var State : String?
    var Institution_Name : String?
    var POC_Name : String?
    var marketing_user_employee_id : String?
}

struct AssignedModel : Codable{
}
