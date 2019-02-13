//
//  Rides.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/12/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation


class Rides {
    var startDate: Date
    var endDate: Date
    var mileageStart: Double
    var mileageEnd: Double
    var notes: String
    
    init(startDate: Date, endDate: Date, mileageStart: Double, mileageEnd: Double, notes: String) {
        self.startDate = startDate
        self.endDate = endDate
        self.mileageStart = mileageStart
        self.mileageEnd = mileageEnd
        self.notes = notes
    }
    
    var dictionary: [String : Any] {
        return [
            RideConstants.startDateKey: startDate,
            RideConstants.endDateKey: endDate,
            RideConstants.mileageStartKey: mileageStart,
            RideConstants.mileageEndKey: mileageEnd,
            RideConstants.noteKey: notes
        ]
    }
}

class RideConstants {
    static let startDateKey = "startDate"
    static let endDateKey = "endDate"
    static let mileageStartKey = "mileageStart"
    static let mileageEndKey = "mileageEnd"
    static let noteKey = "notes"
}
