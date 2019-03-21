//
//  PlanetsTableViewController.swift
//  JSON Example
//
//  Created by Michael Rogers on 3/20/19.
//  Copyright © 2019 Michael Rogers. All rights reserved.
//

import UIKit

class PlanetsTableViewController: UITableViewController {
    
    let planetaryInfo = "https://www.dropbox.com/s/8cawmonf4a6f6nv/planets.json?dl=1"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var planets: [Planet] = []
    
    
    @IBAction func fetchPlanets(_ sender: Any) {
        let urlSession = URLSession.shared
        let url = URL(string: planetaryInfo)
        urlSession.dataTask(with: url!, completionHandler: displayPlanetsInTableView).resume()
    }
    
    func displayPlanetsInTableView(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        
        do {
            let decoder:JSONDecoder = JSONDecoder()
            planets = try decoder.decode([Planet].self, from: data!)
            print(planets) // remove this from a final app
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return planets.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath)
     
     // Configure the cell...
        let planet = planets[indexPath.row]
        cell.textLabel?.text = planet.name
        cell.detailTextLabel?.text = "\(planet.distance)"
     return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
