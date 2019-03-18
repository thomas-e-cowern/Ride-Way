//
//  MaintenanceDetailViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/13/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class MaintenanceDetailViewController: UIViewController {

    @IBOutlet weak var bikeLabel: UILabel!
    @IBOutlet weak var maintenanceDatePicker: UIDatePicker!
    @IBOutlet weak var maintenanceLocationTextfield: UITextField!
    @IBOutlet weak var maintenanceMilesTextfield: UITextField!
    @IBOutlet weak var maintenenceServicePerformedTextfield: UITextField!

    
    var bike: VehicleInfo?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        maintenanceLocationTextfield.layer.borderWidth = 1
        maintenanceLocationTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        maintenanceMilesTextfield.layer.borderWidth = 1
        maintenanceMilesTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        maintenenceServicePerformedTextfield.layer.borderWidth = 1
        maintenenceServicePerformedTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        guard let year = bike?.year,
            let make = bike?.make,
            let model = bike?.model else { return }
        bikeLabel.text = "\(year) \(make) \(model)"
    }
   
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        // Sets up responsive keyboard
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 104
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // Hides responsive keyboard
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func maintenanceSaveButtonPressed(_ sender: Any) {
        let date = maintenanceDatePicker.date
        guard let location = maintenanceLocationTextfield.text,
            let miles = Double(maintenanceMilesTextfield.text!),
            let bikeChosen = bike?.uid,
            let servicePerformed = maintenenceServicePerformedTextfield.text else { return }
        
        MaintenanceController.shared.saveNewMaintenanceRecord(date: date, location: location, servicePerformed: servicePerformed, miles: miles, motorcycleId: bikeChosen) { (maintenenceRecord) in
        }
    }
}
