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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // updating colored borders, dealing with keyboard, and updating bike info
        partsNameTextbo.layer.borderWidth = 1
        partsNameTextbo.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        partsNumberTextbox.layer.borderWidth = 1
        partsNumberTextbox.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        partsSerialTextbox.layer.borderWidth = 1
        partsSerialTextbox.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        partsDescriptionTextbox.layer.borderWidth = 1
        partsDescriptionTextbox.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        partsCostTextbox.layer.borderWidth = 1
        partsCostTextbox.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        updateBike()
    }
    
    // Methods
    @objc func keyboardWillShow(notification: NSNotification) {
        // Sets up responsive keyboard
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // Hides responsive keyboard
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        self.resignFirstResponder()
    }
    
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
