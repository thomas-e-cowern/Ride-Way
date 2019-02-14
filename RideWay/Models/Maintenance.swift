//
//  Maintenance.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/12/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class Maintenance {
    var date: Date
    var location: String
    var servicePerformed: String
    var miles: Double
    var motorcycle: String
    
    init(date: Date, location: String, servicePerformed: String, miles: Double, motorcycle: String) {
        self.date = date
        self.location = location
        self.servicePerformed = servicePerformed
        self.miles = miles
        self.motorcycle = motorcycle
    }
    
    var dictionary: [String : Any] {
        return [
            MaintenanceConstants.dateKey : date,
            MaintenanceConstants.locationKey: location,
            MaintenanceConstants.servicePerformedKey: servicePerformed,
            MaintenanceConstants.milesKey: miles,
            MaintenanceConstants.motorcycleKey: motorcycle
        ]
    }
    
    required convenience init?(dictionary: [String : Any]) {
        guard let date = dictionary[MaintenanceConstants.dateKey] as? Date,
            let location = dictionary[MaintenanceConstants.locationKey] as? String,
            let servicePerformed = dictionary[MaintenanceConstants.servicePerformedKey] as? String,
            let miles = dictionary[MaintenanceConstants.milesKey] as? Double,
            let motorcycle = dictionary[MaintenanceConstants.motorcycleKey] as? String
            else { return nil }
        
        self.init(date: date, location: location, servicePerformed: servicePerformed, miles: miles, motorcycle: motorcycle)
    }
}

class MaintenanceConstants {
    static let dateKey = "date"
    static let locationKey = "location"
    static let servicePerformedKey = "servicePerformed"
    static let milesKey = "miles"
    static let motorcycleKey = "motorcycle"
}
