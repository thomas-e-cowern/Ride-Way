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
    
    var bikeInfo: VehicleInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = tabBarController as? TabViewController
        bikeInfo = tabBar?.bikeInfo
        updateViews()
    }
    
    func updateViews () {
        print(bikeInfo)
        bikeMakeTextfield.text = bikeInfo?.make
        bikeYearTestfield.text = bikeInfo?.year
        bikeModelTextfield.text = bikeInfo?.model
        bikeCityTextfield.text = bikeInfo?.plantCity
        bikeCCTextfield.text = bikeInfo?.displacementCC
        bikeStateTextfield.text = bikeInfo?.plantState
        bikeCITextfield.text = bikeInfo?.displacementCI
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
