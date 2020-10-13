//
//  APIServices.swift
//  VaradhiDemo
//
//  Created by mns on 12/10/20.
//  Copyright © 2020 mns. All rights reserved.
//

import Foundation


class APIServices {
    
    func getAppointmentMonthlyDetails(completion : @escaping (AppointModel?, HTTPURLResponse?, Error?) -> Void){
        
        let formFields = ["user_employeid" : "VI020PE0016","status" : "All","appointment_type" : "Employee","month" : "2020-07-25"]
        
        let networking = NetWorking()
        var r = URLRequest(url: URL(string: "\(BASE_URL)\(END_POINT)\(getMonthlyAppointMent)")!)
        r.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        r.httpBody = networking.createBody(parameters: formFields,boundary: boundary)
        
        networking.fetchRequest(apiType: AppointModel.self, request: r) { (data, response, error) in
            completion(data,response,error)
        }
    }
}



