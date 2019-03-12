//
//  BikeDetailViewController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/17/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class BikeDetailViewController: UIViewController {
    @IBOutlet weak var bikeMakeTextfield: UITextField!
    @IBOutlet weak var bikeYearTestfield: UITextField!
    @IBOutlet weak var bikeModelTextfield: UITextField!
    @IBOutlet weak var bikeCityTextfield: UITextField!
    @IBOutlet weak var bikeCCTextfield: UITextField!
    @IBOutlet weak var bikeStateTextfield: UITextField!
    @IBOutlet weak var bikeCITextfield: UITextField!
    @IBOutlet weak var bikeDetailNavBar: UINavigationBar!
    @IBOutlet weak var bikeImageVIew: UIImageView!
    
    var bikeInfo: VehicleInfo?
    var bikeImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = tabBarController as? TabViewController
        bikeInfo = tabBar?.bikeInfo
        setTabBarTitle()
        updateViews()
        bikeMakeTextfield.layer.borderWidth = 1
        bikeMakeTextfield.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        bikeYearTestfield.layer.borderWidth = 1
        bikeYearTestfield.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        bikeModelTextfield.layer.borderWidth = 1
        bikeModelTextfield.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        bikeCityTextfield.layer.borderWidth = 1
        bikeCityTextfield.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        bikeCCTextfield.layer.borderWidth = 1
        bikeCCTextfield.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        bikeStateTextfield.layer.borderWidth = 1
        bikeStateTextfield.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
        bikeCITextfield.layer.borderWidth = 1
        bikeCITextfield.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.4196078431, blue: 0.1294117647, alpha: 1)
    }
    
    func updateViews () {
        guard let url = bikeInfo?.bikePhotoUrlString else { return }
        DocumentController.shared.loadImagages(url: url) { (image) in
            print("Was an image returned?")
            DispatchQueue.main.async {
                self.bikeImageVIew.image = image
            }
        }
        
        bikeMakeTextfield.text = bikeInfo?.make
        bikeYearTestfield.text = bikeInfo?.year
        bikeModelTextfield.text = bikeInfo?.model
        bikeCityTextfield.text = bikeInfo?.plantCity
        bikeCCTextfield.text = bikeInfo?.displacementCC
        bikeStateTextfield.text = bikeInfo?.plantState
        bikeCITextfield.text = bikeInfo?.displacementCI
    }
    
    func setTabBarTitle () {
        guard let year = bikeInfo?.year,
            let make = bikeInfo?.make,
            let model = bikeInfo?.model else { return }
        bikeDetailNavBar.topItem?.title = "\(year) \(make) \(model)"
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPartsListTableview" {
            if let destinationViewController = segue.destination as? PartsListTableViewController {
                destinationViewController.motorcycle = bikeInfo
            }
        } else {
            if let destinationViewController = segue.destination as? DocumentListTableViewController {
                destinationViewController.motorcycle = bikeInfo
            }
        }
    }
}
