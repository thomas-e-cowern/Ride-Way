//
//  DocumentDetailViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/15/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class DocumentDetailViewController: UIViewController {
    
    @IBOutlet weak var documentNameTextfield: UITextField!
    @IBOutlet weak var documentSelectButton: UIButton!
    @IBOutlet weak var documentPhotoButton: UIButton!
    @IBOutlet weak var documentImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bikeLabel: UILabel!
    
    var bikes: VehicleInfo?
    var bikeChosen: String?
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        print("Bike ID: \(String(describing: bikes?.uid))")
        bikeChosen = bikes?.uid
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        documentNameTextfield.layer.borderWidth = 1
        documentNameTextfield.layer.borderColor = #colorLiteral(red: 0.9245482087, green: 0.3629701734, blue: 0.1816923022, alpha: 1)
        updateBike()
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
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
    func updateBike () {
        // Gets info passed in from partsListTableViewController and updates label text
        guard let year = bikes?.year,
            let make = bikes?.make,
            let model = bikes?.model else { return }
        bikeChosen = bikes?.uid
        bikeLabel.text = "\(String(describing: year)) \(String(describing: make)) \(String(describing: model))"
    }
    
    @IBAction func takeAPhotoButtonTapped(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.documentImageView.image = image
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("Saved Button Tapped")
        imageData = (documentImageView.image)?.jpegData(compressionQuality: 0.2)
        guard let name = documentNameTextfield.text,
            let imageData = imageData else { print("😡 There was a guard return error in \(#function)"); return }
        DocumentController.shared.addImage(data: imageData, name: name, bike: bikeChosen ?? "Error getting bike info")
    }
    
}

//extension DocumentDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func handleSelectedPhoto() {
//        print("Inside Select Photo")
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = true
//        present(picker, animated: true, completion: nil)
//    }
//
//    func handleScanDocument() {
//        print("Inside Handele Scan Doc")
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let bikePicker = UIImagePickerController()
//            bikePicker.delegate = self
//            bikePicker.sourceType = .camera
//            present(bikePicker, animated: true, completion: nil)
//        }
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        var selectedImageFromPicker: UIImage?
//
//        if let editedImage = info[.editedImage] as? UIImage {
//            selectedImageFromPicker = editedImage
//        } else if let imageFromPicker = info[.originalImage] as? UIImage {
//            selectedImageFromPicker = imageFromPicker
//        }
//
//        if let selectImage = selectedImageFromPicker {
//            documentImageView.image = selectImage
//        }
//
//        imageData = (documentImageView.image)?.jpegData(compressionQuality: 0.5)
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_: UIImagePickerController) {
//        print("canceled picker")
//        dismiss(animated: true, completion: nil)
//    }
//}
