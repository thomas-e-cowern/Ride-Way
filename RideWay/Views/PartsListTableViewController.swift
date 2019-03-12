//
//  PartsListTableViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/14/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class PartsListTableViewController: UITableViewController {
    
    @IBOutlet weak var partsNavBar: UINavigationBar!
    
    var motorcycle: VehicleInfo?
    var partsList: [Parts]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarTitle()
        getVehicleList()
        getPartsList()
        partsNavBar.barTintColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
    }

    func setTabBarTitle () {
        guard let year = motorcycle?.year,
            let make = motorcycle?.make,
            let model = motorcycle?.model else { return }
        partsNavBar.topItem?.title = "\(year) \(make) \(model)"
    }
    
    func getVehicleList() {
        VehicleController.shared.fetchVehicles { (vehicles) in
            self.tableView.reloadData()
        }
    }
    
    func getPartsList () {
        guard let bikeId = motorcycle?.uid else { return }
        PartsController.shared.fetchParts(bike: bikeId) { (parts) in
            self.partsList = parts
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return partsList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "partsCell", for: indexPath)
        guard let partName = partsList?[indexPath.row].name else { return UITableViewCell() }
        cell.textLabel?.text = partName
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if editingStyle == .delete {
                guard let partToDelete = partsList?[indexPath.row] else {
                    print("Error in ride delete")
                    return
                }
                
                // Delete the row from the data source
                PartsController.shared.deletePart(part: partToDelete) { (success) in
                    if success == true {
                        print("deleted data")
                        self.partsList?.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        
                    } else {
                        print("problem deleting data")
                    }
                }
            }
        } 
    }
    

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

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPartsDetail" {
            if let destinationViewController = segue.destination as? PartsDetailViewController {
                destinationViewController.bike = motorcycle
            }
        }
    }
    

}
