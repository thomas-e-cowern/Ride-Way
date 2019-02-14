//
//  Maintenance.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/12/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation
import Firebase

class Maintenance {
    var date: Date
    var location: String
    var servicePerformed: String
    var miles: Double
    var motorcycle: String
    var user: String
    var maintenanceId: String
    
    init(date: Date, location: String, servicePerformed: String, miles: Double, motorcycle: String, user: String, maintenanceId: String = UUID().uuidString) {
        self.date = date
        self.location = location
        self.servicePerformed = servicePerformed
        self.miles = miles
        self.motorcycle = motorcycle
        self.user = user
        self.maintenanceId = maintenanceId
    }
    
    var dictionary: [String : Any] {
        return [
            MaintenanceConstants.dateKey : date,
            MaintenanceConstants.locationKey: location,
            MaintenanceConstants.servicePerformedKey: servicePerformed,
            MaintenanceConstants.milesKey: miles,
            MaintenanceConstants.motorcycleKey: motorcycle,
            MaintenanceConstants.userKey: user,
            MaintenanceConstants.maintenanceId: maintenanceId
        ]
    }
    
    required convenience init?(dictionary: [String : Any]) {
        guard let timestamp = dictionary[MaintenanceConstants.dateKey] as? Timestamp,
            let location = dictionary[MaintenanceConstants.locationKey] as? String,
            let servicePerformed = dictionary[MaintenanceConstants.servicePerformedKey] as? String,
            let miles = dictionary[MaintenanceConstants.milesKey] as? Double,
            let motorcycle = dictionary[MaintenanceConstants.motorcycleKey] as? String,
            let user = dictionary[MaintenanceConstants.userKey] as? String,
            let maintenanceId = dictionary[MaintenanceConstants.maintenanceId] as? String
            else { return nil }
        let date = timestamp.dateValue()
        self.init(date: date, location: location, servicePerformed: servicePerformed, miles: miles, motorcycle: motorcycle, user: user, maintenanceId: maintenanceId)
    }
}

class MaintenanceConstants {
    static let dateKey = "date"
    static let locationKey = "location"
    static let servicePerformedKey = "servicePerformed"
    static let milesKey = "miles"
    static let motorcycleKey = "motorcycle"
    static let userKey = "user"
    static let maintenanceId = "maintenanceId"
}
