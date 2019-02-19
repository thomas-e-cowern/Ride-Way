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
//        let tabBar = tabBarController as? TabViewController
//        bikeInfo = tabBar?.bikeInfo
        updateBikeInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateBikeInfo()
    }
    
    func updateBikeInfo() {
        print(bikeInfo?.uid)
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
