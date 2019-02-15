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
    var serialNumber: String
    var description: String
    var cost: Double
    var bikeId: String
    var user: String
    var partId: String
    
    init(name: String, number: String, serialNumber: String, description: String, cost: Double, bikeId: String, user: String, partId: String = UUID().uuidString) {
        self.name = name
        self.number = number
        self.serialNumber = serialNumber
        self.description = description
        self.cost = cost
        self.bikeId = bikeId
        self.user = user
        self.partId = partId
    }
    
    var dictionary: [String : Any] {
        return [
            PartsCodingKeys.nameKey : name,
            PartsCodingKeys.numberKey : number,
            PartsCodingKeys.serialNumberKey : serialNumber,
            PartsCodingKeys.descriptionKey : description,
            PartsCodingKeys.costKey : cost,
            PartsCodingKeys.bikeIdKey : bikeId,
            PartsCodingKeys.userKey  : user,
            PartsCodingKeys.partIdKey : partId
        ]
    }
    
    required convenience init?(dictionary: [String : Any]) {
        guard let name = dictionary[PartsCodingKeys.nameKey] as? String,
            let number = dictionary[PartsCodingKeys.numberKey] as? String,
            let serialNumber = dictionary[PartsCodingKeys.serialNumberKey] as? String,
            let description = dictionary[PartsCodingKeys.descriptionKey] as? String,
            let cost = dictionary[PartsCodingKeys.costKey] as? Double,
            let bikeId = dictionary[PartsCodingKeys.bikeIdKey] as? String,
            let user = dictionary[PartsCodingKeys.userKey] as? String,
            let partId = dictionary[PartsCodingKeys.partIdKey] as? String
            else { return nil }
        self.init(name: name, number: number, serialNumber: serialNumber, description: description, cost: cost, bikeId: bikeId, user: user, partId: partId)
    }
}

class PartsCodingKeys {
    static let nameKey = "name"
    static let numberKey = "number"
    static let serialNumberKey = "serialNumber"
    static let descriptionKey = "descrtiption"
    static let costKey = "cost"
    static let bikeIdKey = "bikeId"
    static let userKey = "user"
    static let partIdKey = "partId"
}
