//
//  BikeImage.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/17/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation
import UIKit

class BikeImage {

    var bikeImage: Data
    
    init(bikeImage: Data) {

        self.bikeImage = bikeImage
    }
    
    var dictionary: [String : Any] {
        return [
            BikeImageCodingKeys.bikeImageKey : "bikeImage"
        ]
    }
    
    required convenience init?(dictionary: [String : Any]) {
        guard let bikeImage = dictionary[BikeImageCodingKeys.bikeImageKey] as? Data
            else { return nil }
        self.init(bikeImage: bikeImage)
    }
}

class BikeImageCodingKeys {
    static let bikeImageKey = "bikeImage"
}
