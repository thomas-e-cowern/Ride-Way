//
//  Parts.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/13/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class Parts {
    var name: String
    var number: String
    var serialNumber: String?
    var description: String?
    var cost: Double?
    var bikeId: String
    
    init(name: String, number: String, serialNumber: String, description: String, cost: Double, bikeId: String) {
        self.name = name
        self.number = number
        self.serialNumber = serialNumber
        self.description = description
        self.cost = cost
        self.bikeId = bikeId
    }
    
    var dictionary: [String : Any] {
        return [
            PartsCodingKeys.nameKey : name,
            PartsCodingKeys.numberKey : number,
            PartsCodingKeys.serialNumberKey : serialNumber as Any,
            PartsCodingKeys.descriptionKey : description as Any,
            PartsCodingKeys.costKey : cost as Any,
            PartsCodingKeys.bikeIdKey : bikeId
        ]
    }
}

class PartsCodingKeys {
    static let nameKey = "name"
    static let numberKey = "number"
    static let serialNumberKey = "serialNumber"
    static let descriptionKey = "descrtiption"
    static let costKey = "cost"
    static let bikeIdKey = "bikeId"
}
