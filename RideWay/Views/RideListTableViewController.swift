//
//  RideListTableViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/14/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class RideListTableViewController: UITableViewController {
    
    @IBOutlet weak var rideNavBar: UINavigationBar!
    
    var motorcycle: VehicleInfo?
    var rides: [Rides]?
    var bikeInfo: VehicleInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rideNavBar.barTintColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        let tabBar = tabBarController as? TabViewController
        bikeInfo = tabBar?.bikeInfo
        print("RLVC: \(String(describing: bikeInfo?.uid))")
        getRidesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func getRidesList () {
        print("Inside getRidesList")
        guard let bikeId = bikeInfo?.uid else { return }
        RidesController.shared.fetchRides(bike: bikeId) { (returnedRides) in
            self.rides = returnedRides
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
        return rides?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rideCell", for: indexPath)
        let ride = rides?[indexPath.row]
        guard let startDate = ride?.startDate.asPrettyString,
            let notes = ride?.notes else { return UITableViewCell() }
        let rideInfo = "\(startDate) : \(notes)"
        cell.textLabel?.text = rideInfo
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    @IBAction func homeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let rideToDelete = rides?[indexPath.row] else {
                print("Error in ride delete")
                return
            }
            
            // Delete the row from the data source
            RidesController.shared.deleteRide(ride: rideToDelete) { (success) in
                if success == true {
                    print("deleted data")
                    self.rides?.remove(at: indexPath.row)
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRideDetail" {
            if let destinationViewController = segue.destination as? RideDetailViewController {
                destinationViewController.bikeInfo = bikeInfo
            }
        } else {
            if let destinationViewController = segue.destination as? RideDetailViewController {
                destinationViewController.bikeInfo = bikeInfo
            }
        }
    }
    

}
