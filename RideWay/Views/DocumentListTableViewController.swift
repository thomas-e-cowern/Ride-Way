//
//  DocumentListTableViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/15/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class DocumentListTableViewController: UITableViewController {
    
    var motorcycles: [VehicleInfo]? = []
    var documentList: [Documentation]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVehicleList()
    }
    
    func getVehicleList() {
        VehicleController.shared.fetchVehicles { (vehicles) in
            self.motorcycles = vehicles
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentList?.count ?? 0
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        let document = documentList?[indexPath.row]
        let name = document?.name
        cell.textLabel?.text = name
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
        if segue.identifier == "toDocumentDetail" {
            if let destinationViewController = segue.destination as? DocumentDetailViewController {
                destinationViewController.bikes = motorcycles
            }
        }
    }
    
}
