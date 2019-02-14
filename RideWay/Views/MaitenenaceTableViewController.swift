//
//  MaitenenaceTableViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/13/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class MaitenenaceTableViewController: UITableViewController {
    
    var dataSource: [VehicleInfo]?
    var maintenanceRecords: [Maintenance]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getVehicleList()
        getMaintenanceList()
    }

    func getVehicleList() {
        VehicleController.shared.fetchVehicles { (vehicles) in
            self.dataSource = vehicles
            self.tableView.reloadData()
        }
    }
    
    func getMaintenanceList () {
        MaintenanceController.shared.fetchMaintenanceRecords { (maintenence) in
            self.maintenanceRecords = maintenence
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
        return maintenanceRecords?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maintenanceCell", for: indexPath)
        let maintenanceRecord = maintenanceRecords?[indexPath.row].date
        cell.textLabel?.text = "Service performed on: \(maintenanceRecord)"
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

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMaintenanceDetail" {
            if let destinationViewController = segue.destination as? MaintenanceDetailViewController {
                destinationViewController.bikes = dataSource
            }
        }
    }
}
