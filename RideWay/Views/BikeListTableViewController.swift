//
//  BikeListTableViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/11/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit
import Firebase

class BikeListTableViewController: UITableViewController {
    
    var bikeCount: Int = 0
    var bikeInfo: [String : Any] = [:]
    var bikeArray: [String] = []
    var dataSource: [VehicleInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getVehicleList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getVehicleList()
        tableView.reloadData()
    }

    // MARK: - Methods
    func getVehicleList() {
        VehicleController.shared.fetchVehicles { (vehicles) in
            self.dataSource = vehicles
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bikeCell", for: indexPath)
        guard let year = dataSource?[indexPath.row].year,
            let make = dataSource?[indexPath.row].make,
            let model = dataSource?[indexPath.row].model else { return UITableViewCell() }
        let bike = "\(year) \(make) \(model)"
        cell.textLabel?.text = bike
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let vehicle = dataSource?[indexPath.row] else {
                print("Error in vehicle delete")
                return
            }
            
            // Delete the row from the data source
            VehicleController.shared.deleteMotorcycle(motorcycle: vehicle) { (success) in
                if success == true {
                    print("deleted data")
                    self.dataSource?.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } else {
                    print("problem deleting data")
                }
               
            }
        }
    }
//    UITableViewCell.EditingStyle

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
