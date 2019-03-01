//
//  RideDetailViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/14/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class RideDetailViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var bikeLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var mileageStartTextfield: UITextField!
    @IBOutlet weak var mileageEndTextfield: UITextField!
    @IBOutlet weak var notesTextfield: UITextField!
    
    // MARK: - Properties
    var Ride: Rides?
    var bikeInfo: VehicleInfo?
    var bikeChosen: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mileageStartTextfield.layer.borderWidth = 1
        mileageStartTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        mileageEndTextfield.layer.borderWidth = 1
        mileageEndTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        notesTextfield.layer.borderWidth = 1
        notesTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        updateBikeInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateBikeInfo()
    }
    
    func updateBikeInfo() {
        print(bikeInfo?.uid)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    // MARK: - Actions
    @IBAction func saveRideButtonTapped(_ sender: Any) {
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
        guard let startMileage = Double(mileageStartTextfield.text!),
            let endMileage = Double(mileageEndTextfield.text!),
            let bike = bikeInfo?.uid,
            let notes = notesTextfield.text else { return }
        
        RidesController.shared.saveNewRide(startDate: startDate, endDate: endDate, mileageStart: startMileage, mileageEnd: endMileage, notes: notes, bikeId: bike) { (ride) in
            print("saved ride")
        }
    }
    
    
}
