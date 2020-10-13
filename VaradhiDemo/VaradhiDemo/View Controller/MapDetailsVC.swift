//
//  MapDetailsVC.swift
//  VaradhiDemo
//
//  Created by mns on 12/10/20.
//  Copyright © 2020 mns. All rights reserved.
//

import UIKit

import GoogleMaps

class MapDetailsVC: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    var addressDetails : AppointmentModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = "\(addressDetails.Address_Line_1 ?? ""), \(addressDetails.Address_Line_2 ?? ""), \(addressDetails.Land_Mark ?? ""), \(addressDetails.City ?? ""), \(addressDetails.State ?? ""), \(addressDetails.PIN ?? 0)"
        addressLabel.text = location
        
        print(location)
        
        let camera = GMSCameraPosition.camera(withLatitude: 12.9716,
                                              longitude: 77.5946,
                                              zoom: 15)
        mapView.camera = camera
        mapView.animate(to: camera)

        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)
        marker.title = addressDetails.Land_Mark
        marker.snippet = addressDetails.City
        marker.map = mapView
        
        peformGeeoCoding(for:location)
    }
    
    func peformGeeoCoding(for string: String) {
        var components = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")!
        let key = URLQueryItem(name: "key", value: apiKey) // use your key
        let address = URLQueryItem(name: "address", value: string)
        components.queryItems = [key, address]

        let task = URLSession.shared.dataTask(with: components.url!) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                print(String(describing: response))
                print(String(describing: error))
                return
            }

            guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
                print("not JSON format expected")
                print(String(data: data, encoding: .utf8) ?? "Not string?!?")
                return
            }

            guard let results = json["results"] as? [[String: Any]],
                let status = json["status"] as? String,
                status == "OK" else {
                    print("no results")
                    print(String(describing: json))
                    return
            }

            DispatchQueue.main.async {
                // now do something with the results, e.g. grab `formatted_address`:
                let strings = results.compactMap { $0["formatted_address"] as? String }
                print("result",strings)
            }
        }
        task.resume()
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
      }
}
