//
//  NewVehicleViewController.swift
//  FirebaseAuth
//
//  Created by Thomas Cowern New on 2/7/19.
//

import UIKit
import Firebase

class NewVehicleViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var vinTextfield: UITextField!
    @IBOutlet weak var vinButton: UIButton!
    @IBOutlet weak var vinTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var displacementCITextField: UITextField!
    @IBOutlet weak var displacementCCTextField: UITextField!
    @IBOutlet weak var plantStateTextField: UITextField!
    @IBOutlet weak var plantCityTextField: UITextField!
    
    // MARK: - Properties
    var vehicleInfo: [VehicleInfo] = []
    let bikeInfo: VehicleInfo? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    @IBAction func getVinButtonTapped(_ sender: Any) {
        guard let userVin = vinTextfield.text else {
            print("Problem getting the user vin from the textField")
            return
        }
    
        VehicleController.shared.fetchVinResults(with: userVin) { (returnInfo) in
            guard let vehicleInfo = returnInfo else {
                print("Problem getting vehicleInfo in VehicleController")
                return
            }
            print("🧿🧿🧿🧿🧿\(vehicleInfo)🧿🧿🧿🧿🧿")
            DispatchQueue.main.async {
                self.vinTextField.text = vehicleInfo.vin
                self.yearTextField.text = vehicleInfo.year
                self.makeTextField.text = vehicleInfo.make
                self.modelTextField.text = vehicleInfo.model
                self.displacementCCTextField.text = vehicleInfo.displacementCC
                self.displacementCITextField.text = vehicleInfo.displacementCI
                self.plantStateTextField.text = vehicleInfo.plantState
                self.plantCityTextField.text = vehicleInfo.plantCity
            }
        }
    }
    
    @IBAction func saveBikeTapped(_ sender: Any) {

        guard let displacementCC = displacementCCTextField.text,
        let displacementCI = displacementCITextField.text,
        let make = makeTextField.text,
        let model = modelTextField.text,
        let year = yearTextField.text,
        let plantCity = plantCityTextField.text,
        let plantState = plantStateTextField.text,
        let vin = vinTextField.text else { return }
        let uid = ""
        
        VehicleController.shared.createVehicleInfo(displacementCC: displacementCC, displacementCI: displacementCI, make: make, model: model, year: year, plantCity: plantCity, plantState: plantState, vin: vin) { (vehicle) in
            print("vehicle saved: \(vehicle)")
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
