//
//  MaintenanceDetailViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/13/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class MaintenanceDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var maintenanceDatePicker: UIDatePicker!
    @IBOutlet weak var maintenanceBikePicker: UIPickerView!
    @IBOutlet weak var maintenanceLocationTextfield: UITextField!
    @IBOutlet weak var maintenanceMilesTextfield: UITextField!
    @IBOutlet weak var maintenenceServicePerformedTextfield: UITextField!

    
    var bikes: [VehicleInfo]? = []
    var bikeChosen: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        maintenanceBikePicker.delegate = self
//        let userId = FirebaseController.shared.userId
//        print("Maintenance Controller userId: \(userId)")
//        bikes = ["Bike 1", "Bike 2", "Bike 3", "Bike 4"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bikes?.count ?? 0
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let year = bikes?[row].year,
            let make = bikes?[row].make,
            let model = bikes?[row].model else { return nil }
         return "\(year) \(make) \(model)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bikeChosen = bikes?[row].uid
    }
   
    @IBAction func maintenanceSaveButtonPressed(_ sender: Any) {
        let date = maintenanceDatePicker.date
        guard let bike = bikeChosen,
            let location = maintenanceLocationTextfield.text,
            let miles = Double(maintenanceMilesTextfield.text!),
            let servicePerformed = maintenenceServicePerformedTextfield.text else { return }
        
        MaintenanceController.shared.saveNewMaintenanceRecord(date: date, location: location, servicePerformed: servicePerformed, miles: miles, motorcycleId: bike) { (maintenenceRecord) in
            print("Maintenece Record saved: \(maintenenceRecord)")
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
