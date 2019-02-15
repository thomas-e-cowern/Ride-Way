//
//  DocumentDetailViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/15/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class DocumentDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var documentPicker: UIPickerView!
    @IBOutlet weak var documentNameTextfield: UITextField!
    @IBOutlet weak var documentSelectButton: UIButton!
    @IBOutlet weak var documentPhotoButton: UIButton!
    @IBOutlet weak var documentImageView: UIImageView!
    
    var bikes: [VehicleInfo]? = []
    var bikeChosen: String?
    var imageData: NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        documentPicker.delegate = self
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
    
    
    
    @IBAction func selectDocumentationTapped(_ sender: Any) {
       handleSelectedPhoto()
    }
    
    @IBAction func takeAPhotoButtonTapped(_ sender: Any) {
       
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = documentNameTextfield.text,
            let imageData = imageData,
            let bikeChosen = bikeChosen else { return }
        DocumentController.shared.addImage(data: imageData, name: name, bike: bikeChosen)
    }
    
}

extension DocumentDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func handleSelectedPhoto() {
        print("Inside Select Photo")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let imageFromPicker = info[.originalImage] as? UIImage {
            selectedImageFromPicker = imageFromPicker
        }
        
        if let selectImage = selectedImageFromPicker {
            documentImageView.image = selectImage
        }

        imageData = (selectedImageFromPicker)?.jpegData(compressionQuality: 0.5) as NSData?
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
}
