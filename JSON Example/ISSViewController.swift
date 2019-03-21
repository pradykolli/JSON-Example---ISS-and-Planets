//
//  ViewController.swift
//  JSON Example
//
//  Created by Michael Rogers on 11/4/18.
//  Copyright © 2019 Michael Rogers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ISSViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var latitudeLBL: UILabel!
    
    @IBOutlet weak var longitudeLBL: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
        override func viewWillAppear(_ animated: Bool) {
       
    }
    @IBAction func fetchISSData(){
        let urlSession = URLSession.shared
        let url = URL(string: "http://api.open-notify.org/iss-now.json")!
        urlSession.dataTask(with: url, completionHandler: showISSData).resume()
    }
    
    func showISSData(data:Data?, urlResponse:URLResponse?, error:Error?){
        do {
            let decoder = JSONDecoder()
            let location = try decoder.decode(IssLocation.self, from: data!)
            DispatchQueue.main.async {
                self.latitudeLBL.text = location.iss_position.latitude
                self.longitudeLBL.text = location.iss_position.longitude
            }
        }catch {
            print(error)
        }
    }

}

