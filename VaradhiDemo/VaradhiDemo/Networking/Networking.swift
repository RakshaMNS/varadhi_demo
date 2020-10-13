//
//  NetWorking.swift
//  VaradhiDemo
//
//  Created by mns on 12/10/20.
//  Copyright © 2020 mns. All rights reserved.
//
import Foundation

enum HTTPMethod : String {
    case POST = "POST"   
}

class NetWorking {
    
    let session = URLSession(configuration: .default)
    
    /*
     queryParams: query parameters
     **/
    
    func createBody(parameters: [String: String],boundary: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    /********************************************************************************************************************************/
    func fetchRequest<T : Decodable>(apiType: T.Type, request : URLRequest, completion : @escaping (T?, HTTPURLResponse?, Error?) -> Void ){
        let task = session.dataTask(with : request) {
            (data, response, error) in
            var result : T?
            if let httpResponse = response as? HTTPURLResponse {
                if error == nil && (httpResponse.statusCode == 200 || httpResponse.statusCode == 201) {
                    do{
                        result = try JSONDecoder().decode(apiType.self, from: data!)
                        completion(result, httpResponse,nil)
                    }
                    catch {
                        completion(nil, httpResponse, error)
                    }
                    
                }else {
                    completion(nil, httpResponse, error)
                }
            }else {
                completion(nil, nil,error)
            }
        }
        task.resume()
    }
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
