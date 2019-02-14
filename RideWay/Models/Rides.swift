//
//  Rides.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/12/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation
import Firebase

class Rides {
    var startDate: Date
    var endDate: Date
    var mileageStart: Double
    var mileageEnd: Double
    var notes: String
    var bike: String
    var user: String
    var rideId: String
    
    init(startDate: Date, endDate: Date, mileageStart: Double, mileageEnd: Double, notes: String, bike: String, user: String, rideId: String) {
        self.startDate = startDate
        self.endDate = endDate
        self.mileageStart = mileageStart
        self.mileageEnd = mileageEnd
        self.notes = notes
        self.bike = bike
        self.user = user
        self.rideId = rideId
    }
    
    var dictionary: [String : Any] {
        return [
            RideConstants.startDateKey: startDate,
            RideConstants.endDateKey: endDate,
            RideConstants.mileageStartKey: mileageStart,
            RideConstants.mileageEndKey: mileageEnd,
            RideConstants.noteKey: notes,
            RideConstants.motorcycleKey: bike,
            RideConstants.userKey: user,
            RideConstants.rideIdKey: rideId
        ]
    }
    
    required convenience init?(dictionary: [String : Any]) {
        guard let SDTimestamp = dictionary[RideConstants.startDateKey] as? Timestamp,
            let EDTimestamp = dictionary[RideConstants.endDateKey] as? Timestamp,
            let mileageStart = dictionary[RideConstants.mileageStartKey] as? Double,
            let mileageEnd = dictionary[RideConstants.mileageEndKey] as? Double,
            let notes = dictionary[RideConstants.noteKey] as? String,
            let motorcycle = dictionary[RideConstants.motorcycleKey] as? String,
            let user = dictionary[RideConstants.userKey] as? String,
            let rideId = dictionary[RideConstants.rideIdKey] as? String
            else { return nil }
        let startDate = SDTimestamp.dateValue()
        let endDate = EDTimestamp.dateValue()
        self.init(startDate: startDate, endDate: endDate, mileageStart: mileageStart, mileageEnd: mileageEnd, notes: notes, bike: motorcycle, user: user, rideId: rideId)
    }
}

class RideConstants {
    static let startDateKey = "startDate"
    static let endDateKey = "endDate"
    static let mileageStartKey = "mileageStart"
    static let mileageEndKey = "mileageEnd"
    static let noteKey = "notes"
    static let motorcycleKey = "bike"
    static let userKey = "user"
    static let rideIdKey = "rideId"
}
