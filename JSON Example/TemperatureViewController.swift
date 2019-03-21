//
//  WeatherViewController.swift
//  JSON Example - ISS and Planets
//
//  Created by Michael Rogers on 3/21/19.
//  Copyright © 2019 Michael Rogers. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    let openWeatherMapAPIKey = "a1abccef6df6b8394e2c03adb61dd398"
    
    var openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather?id=5056172&appid=xxxx&units=imperial"
    
    // called to start the temperature fetching process
    @IBAction func fetchTemperature(_ sender:Any?) -> Void {
        
        openWeatherMapURL = openWeatherMapURL.replacingOccurrences(of: "xxxx", with: openWeatherMapAPIKey)
        let urlSession = URLSession.shared
        let url = URL(string: openWeatherMapURL)
        urlSession.dataTask(with: url!, completionHandler: displayTemperature).resume()
    }
    
    func displayTemperature(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        var weatherRecord:[String:Any]!
        var mainRecord:[String:Any]!
        do {
            try weatherRecord = JSONSerialization.jsonObject(with: data!,
                                                             options: .allowFragments) as? [String:Any]
            if weatherRecord != nil {
                mainRecord = weatherRecord["main"]! as? [String:Any] // not [String:Double]
                let temperature = mainRecord["temp"]! as! Double
                display(message:String(format:"%.1f °F", temperature))
            }
        }catch {
            print(error)
        }
    }
    
    func display(message:String)->Void {
        let alertController = UIAlertController(title: "Temperature", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
        
    }

    
}
