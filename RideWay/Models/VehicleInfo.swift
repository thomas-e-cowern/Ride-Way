//
//  VehicleInfo.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/8/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class VehicleInfo: FirebaseObject {
    
    static var collectionName: String = "bikes"
    let displacementCC: String
    let displacementCI: String
    let make: String
    let model: String
    let year: String
    let plantCity: String
    let plantState: String
    let vin: String
    var uid: String
    var userId: String
    var bikePhotoUrlString: String?
    
    var dictionary: [String : Any] {
        return [
            VehicleInfoConstants.vinKey : vin,
            VehicleInfoConstants.makeKey : make,
            VehicleInfoConstants.modelKey : model,
            VehicleInfoConstants.yearKey: year,
            VehicleInfoConstants.displacementCCKey: displacementCC,
            VehicleInfoConstants.displacementCIKey: displacementCI,
            VehicleInfoConstants.plantCity: plantCity,
            VehicleInfoConstants.plantState: plantState,
            VehicleInfoConstants.uid: uid,
            VehicleInfoConstants.userId: userId,
            VehicleInfoConstants.bikePhotoUrlString: bikePhotoUrlString
        ]
    }
    
    init(displacementCC: String, displacementCI: String, make: String, model: String, year: String, plantCity: String, plantState: String, vin: String, uid: String = UUID().uuidString, userId: String = "", bikePhotoUrlString: String = "") {
        self.displacementCC = displacementCC
        self.displacementCI = displacementCI
        self.make = make
        self.model = model
        self.year = year
        self.plantCity = plantCity
        self.plantState = plantState
        self.vin = vin
        self.uid = uid
        self.userId = userId
        self.bikePhotoUrlString = bikePhotoUrlString
    }
    
    required convenience init?(dictionary: [String : Any]) {
        guard let vin = dictionary[VehicleInfoConstants.vinKey] as? String,
            let year = dictionary[VehicleInfoConstants.yearKey] as? String,
            let make = dictionary[VehicleInfoConstants.makeKey] as? String,
            let model = dictionary[VehicleInfoConstants.modelKey] as? String,
            let displacementCC = dictionary[VehicleInfoConstants.displacementCCKey] as? String,
            let displacementCI = dictionary[VehicleInfoConstants.displacementCIKey] as? String,
            let plantCity = dictionary[VehicleInfoConstants.plantCity] as? String,
            let plantState = dictionary[VehicleInfoConstants.plantState] as? String,
            let uid = dictionary[VehicleInfoConstants.uid] as? String,
            let userId = dictionary[VehicleInfoConstants.userId] as? String,
            let bikePhotoUrlString = dictionary[VehicleInfoConstants.bikePhotoUrlString] as? String
            else {
                print("Problem in convienence init")
                return nil
            }

        
        self.init(displacementCC: displacementCC, displacementCI: displacementCI, make: make, model: model, year: year, plantCity: plantCity, plantState: plantState, vin: vin, uid: uid, userId: userId, bikePhotoUrlString: bikePhotoUrlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case displacementCC = "DisplacementCC"
        case displacementCI = "DisplacementCI"
        case make = "Make"
        case model = "Model"
        case year  = "ModelYear"
        case plantCity = "PlantCity"
        case plantState = "PlantState"
        case vin = "VIN"
        case uid = "uid"
        case bikePhotoUrlString = "bikePhotoUrlString"
    }
    
}

class VehicleInfoConstants {
    static let vinKey = "vin"
    static let yearKey = "year"
    static let makeKey = "make"
    static let modelKey = "model"
    static let displacementCCKey = "displacementCC"
    static let displacementCIKey = "displacementCI"
    static let plantCity = "plantCity"
    static let plantState = "plantState"
    static let uid = "uid"
    static let userId = "userId"
    static let bikePhotoUrlString = "bikePhotoUrlString"
}

