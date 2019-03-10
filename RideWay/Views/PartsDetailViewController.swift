//
//  PartsDetailViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/14/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class PartsDetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var partsBikeLabel: UILabel!
    @IBOutlet weak var partsNameTextbo: UITextField!
    @IBOutlet weak var partsNumberTextbox: UITextField!
    @IBOutlet weak var partsSerialTextbox: UITextField!
    @IBOutlet weak var partsDescriptionTextbox: UITextField!
    @IBOutlet weak var partsCostTextbox: UITextField!
    
    // Properties
    var bike: VehicleInfo?
    var part: Parts?
    var bikeChosen: String?

    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBike()
        
    }
    
    // Methods
    func updateBike () {
        // Gets info passed in from partsListTableViewController and updates label text
        guard let year = bike?.year,
        let make = bike?.make,
            let model = bike?.model else { return }
        bikeChosen = bike?.uid
        partsBikeLabel.text = "\(String(describing: year)) \(String(describing: make)) \(String(describing: model))"
    }
    
    // Actions
    @IBAction func partsSavedButtonTapped(_ sender: Any) {
        // Gets user entered info and creates a new part and saves to database
        guard let bike = bikeChosen,
            let partName = partsNameTextbo.text,
            let partNumber = partsNumberTextbox.text,
            let serialNumber = partsSerialTextbox.text,
            let description = partsDescriptionTextbox.text,
            let cost = Double(partsCostTextbox.text!) else { return }
        
        PartsController.shared.saveNewPart(name: partName, number: partNumber, serialNumber: serialNumber, description: description, cost: cost, bikeId: bike) { (part) in
            
        }
    }
}
