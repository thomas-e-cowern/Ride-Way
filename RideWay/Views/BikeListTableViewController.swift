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
    
    @IBOutlet weak var bikeNavBar: UINavigationBar!
    
    var bikeCount: Int = 0
    var bikeInfo: [String : Any] = [:]
    var bikeArray: [String] = []
    var dataSource: [VehicleInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().isPersistenceEnabled = true
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        getVehicleList()
        bikeNavBar.barTintColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "bikeCell", for: indexPath) as! BikeListTableViewCell
        let bike = dataSource?[indexPath.row]
        cell.bike = bike
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }

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
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBikeDetail" {
            if let destinationViewController = segue.destination as? TabViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let bikeInfo = dataSource?[indexPath.row]
                    destinationViewController.bikeInfo = bikeInfo
                }
            }
        }
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
