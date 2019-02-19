//
//  PartsDetailViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/14/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class PartsDetailViewController: UIViewController {
    
    @IBOutlet weak var partsBikeLabel: UILabel!
    @IBOutlet weak var partsNameTextbo: UITextField!
    @IBOutlet weak var partsNumberTextbox: UITextField!
    @IBOutlet weak var partsSerialTextbox: UITextField!
    @IBOutlet weak var partsDescriptionTextbox: UITextField!
    @IBOutlet weak var partsCostTextbox: UITextField!
    
    var bike: VehicleInfo?
    var part: Parts?
    var bikeChosen: String?

    override func viewDidLoad() {
        super.viewDidLoad()
//        partsBikePickerview.delegate = self
        updateBike()
        
    }
    
    func updateBike () {
        guard let year = bike?.year,
        let make = bike?.make,
            let model = bike?.model else { return }
        bikeChosen = bike?.uid
        partsBikeLabel.text = "\(String(describing: year)) \(String(describing: make)) \(String(describing: model))"
    }
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return bikes?.count ?? 0
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        guard let year = bikes?[row].year,
//            let make = bikes?[row].make,
//            let model = bikes?[row].model else { return nil }
//        return "\(year) \(make) \(model)"
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        bikeChosen = bikes?[row].uid
//    }
    
    @IBAction func partsSavedButtonTapped(_ sender: Any) {
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
