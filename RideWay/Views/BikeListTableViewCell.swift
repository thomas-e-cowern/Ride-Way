//
//  BikeListTableViewCell.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/19/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class BikeListTableViewCell: UITableViewCell {

    @IBOutlet weak var bikeListTableviewCell: UIImageView!
    @IBOutlet weak var bikeListTableviewLabel: UILabel!
    
    var bike: VehicleInfo? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        print("BLTVC: \(String(describing: bike?.bikePhotoUrlString))")
        guard let bike = bike else { return }
        guard let url = bike.bikePhotoUrlString else { return }
        let year = bike.year, make = bike.make, model = bike.model
        let bikeDescription = "\(year) \(make) \(model)"
        
        DocumentController.shared.loadImagages(url: url) { (image) in
            print("Was an image returned?")
            DispatchQueue.main.async {
                self.bikeListTableviewCell.image = image
            }
        }
        
        DispatchQueue.main.async {
            self.bikeListTableviewLabel.text = bikeDescription
        }
    }
}
