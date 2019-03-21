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

class ISSViewControllerWithMapView: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var latitudeLBL: UILabel!
    
    @IBOutlet weak var longitudeLBL: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    // TODO: Supply a pin annotation view rather than the more blobby annotation view
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "anno") as? MKPinAnnotationView
        if annotationView == nil {
            // no annotation view, we'll make one ...
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "anno")
            annotationView!.canShowCallout = true
            annotationView!.pinTintColor = UIColor.green
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView

    }
    override func viewWillAppear(_ animated: Bool) {
        let latDist = 13832_e3
        let longDist = 25_000e3
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), latitudinalMeters: latDist, longitudinalMeters: longDist)
        mapView.setRegion(region, animated: true)
        
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
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.iss_position.latitude)!, longitude: Double(location.iss_position.longitude)!)
                annotation.title = "ISS"
                print(annotation.coordinate)
                self.mapView.addAnnotation(annotation)
            }
        }catch {
            print(error)
        }
    }

}

