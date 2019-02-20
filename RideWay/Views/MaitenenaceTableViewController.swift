//
//  MaitenenaceTableViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/13/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class MaitenenaceTableViewController: UITableViewController {
    
    @IBOutlet weak var maintenanceNavBar: UINavigationBar!
    
    var dataSource: [VehicleInfo]?
    var maintenanceRecords: [Maintenance]?
    var bikeInfo: VehicleInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        getVehicleList()
        getMaintenanceList()
        maintenanceNavBar.barTintColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBar = tabBarController as? TabViewController
        bikeInfo = tabBar?.bikeInfo
        print("MLVC: \(bikeInfo?.uid)")
        getMaintenanceList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getMaintenanceList()
    }

    func getVehicleList() {
        VehicleController.shared.fetchVehicles { (vehicles) in
            self.dataSource = vehicles
            self.tableView.reloadData()
        }
    }
    
    func getMaintenanceList () {
        guard let bikeId = bikeInfo?.uid else { return }
        MaintenanceController.shared.fetchMaintenanceRecords(bike: bikeId) { (maintenence) in
            self.maintenanceRecords = maintenence
//            print("👻 MR:\(self.maintenanceRecords)")
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
        guard let servicePerformed = maintenanceRecords?[indexPath.row].servicePerformed,
            let datePerformed = maintenanceRecords?[indexPath.row].date else { return UITableViewCell() }
        let maintenanceSummary = "\(servicePerformed) \(datePerformed.asPrettyString)"
        cell.textLabel?.text = maintenanceSummary
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
            
            guard let maintenanceRecords = maintenanceRecords?[indexPath.row] else {
                print("Error in maintenance delete")
                return
            }
            
            // Delete the row from the data source
            MaintenanceController.shared.deleteMaintenance(record: maintenanceRecords) { (success) in
                if success == true {
                    print("deleted data")
                    self.maintenanceRecords?.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)

                } else {
                    print("problem deleting data")
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
        if segue.identifier == "toMaintenanceDetail" {
            if let destinationViewController = segue.destination as? MaintenanceDetailViewController {
                destinationViewController.bikes = dataSource
            }
        }
    }
}
