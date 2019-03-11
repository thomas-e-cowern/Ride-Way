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
    @IBOutlet weak var addBikePictureButtonPressed: UIButton!
//    @IBOutlet weak var vinTextfield: UITextField!
//    @IBOutlet weak var vinButton: UIButton!
//    @IBOutlet weak var vinTextField: UITextField!
    @IBOutlet weak var addBikeImageView: UIImageView!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var displacementCITextField: UITextField!
    @IBOutlet weak var displacementCCTextField: UITextField!
    @IBOutlet weak var plantStateTextField: UITextField!
    @IBOutlet weak var plantCityTextField: UITextField!
    @IBOutlet weak var cancelButtonPressed: UIButton!
    
    // MARK: - Properties
    var vehicleInfo: [VehicleInfo] = []
    let bikeInfo: VehicleInfo? = nil
    var imageData: Data?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        vinTextfield.layer.borderWidth = 1
//        vinTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        yearTextField.layer.borderWidth = 1
        yearTextField.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        makeTextField.layer.borderWidth = 1
        makeTextField.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        modelTextField.layer.borderWidth = 1
        modelTextField.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        displacementCCTextField.layer.borderWidth = 1
        displacementCCTextField.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        displacementCITextField.layer.borderWidth = 1
        displacementCITextField.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        plantCityTextField.layer.borderWidth = 1
        plantCityTextField.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        plantStateTextField.layer.borderWidth = 1
        plantStateTextField.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
    }
    
    // MARK: - Methods
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
    
    @IBAction func addBikePictureButtonPressed(_ sender: Any) {
        print("Print Button Clicked")
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.addBikeImageView.image = image
        }
    }
    
    @IBAction func getVinButtonTapped(_ sender: Any) {
//        guard let userVin = vinTextfield.text else {
//            print("Problem getting the user vin from the textField")
//            return
//        }
    
//        VehicleController.shared.fetchVinResults(with: userVin) { (returnInfo) in
//            guard let vehicleInfo = returnInfo else {
//                print("Problem getting vehicleInfo in VehicleController")
//                return
//            }
//            print("🧿🧿🧿🧿🧿\(vehicleInfo)🧿🧿🧿🧿🧿")
//            DispatchQueue.main.async {
////                self.vinTextfield.text = vehicleInfo.vin
//                self.yearTextField.text = vehicleInfo.year
//                self.makeTextField.text = vehicleInfo.make
//                self.modelTextField.text = vehicleInfo.model
//                self.displacementCCTextField.text = vehicleInfo.displacementCC
//                self.displacementCITextField.text = vehicleInfo.displacementCI
//                self.plantStateTextField.text = vehicleInfo.plantState
//                self.plantCityTextField.text = vehicleInfo.plantCity
//            }
//        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBikeTapped(_ sender: Any) {
        
        guard let imageData = (addBikeImageView.image)?.jpegData(compressionQuality: 0.4) else { return }
        guard let displacementCC = displacementCCTextField.text,
        let displacementCI = displacementCITextField.text,
        let make = makeTextField.text,
        let model = modelTextField.text,
        let year = yearTextField.text,
        let plantCity = plantCityTextField.text,
        let plantState = plantStateTextField.text else { return }
        let vin = ""
        let uid = ""
        
        VehicleController.shared.saveVehicleInfo(displacementCC: displacementCC, displacementCI: displacementCI, make: make, model: model, year: year, plantCity: plantCity, plantState: plantState, vin: vin, image: imageData) { (vehicle) in
            print("vehicle saved: \(String(describing: vehicle))")
        }
    }
}

