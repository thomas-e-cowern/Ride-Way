//
//  DocumentListTableViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/15/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class DocumentListTableViewController: UITableViewController {
    @IBOutlet weak var documentNavBar: UINavigationBar!
    
    var motorcycle: VehicleInfo? 
    var documentList: [Documentation?] = []
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarTitle()
        getDocuments()
        documentNavBar.barTintColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
    }
    
    func getDocuments() {
        guard let bikeId = motorcycle?.uid else { return }
        DocumentController.shared.fetchDocuemnts(bike: bikeId) { (documents) in
            guard let documents = documents else { return }
            print("DOCS: \(documents.count)")
            self.documentList = documents
            self.tableView.reloadData()
        }
    }
    
    func setTabBarTitle () {
        guard let year = motorcycle?.year,
            let make = motorcycle?.make,
            let model = motorcycle?.model else { return }
        documentNavBar.topItem?.title = "\(year) \(make) \(model)"
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentList.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath) as! DocumentListTableViewCell
        let document = documentList[indexPath.row]
        cell.document = document
        return cell
     }
    
//    func getPartsList () {
//        DocumentController.shared.loadImagages(document: <#T##Documentation#>) { (docs) in
//            self.documentList = docs
//            self.tableView.reloadData()
//        }
//    }
    
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
                destinationViewController.bikes = motorcycle
            }
        }
    }
}
