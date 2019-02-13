//
//  PreRideChecklist.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/12/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class PreRideChecklist {
    var fluids: Bool
    var brakes: Bool
    var battery: Bool
    var tires: Bool
    var footPegs: Bool
    var lightSignals: Bool
    var mirrors: Bool
    var horn: Bool
    var motorcycle: String
    
    var dictionary: [String : Any] {
        return [
            PreRideChecklistConstants.fluidsKey : fluids,
            PreRideChecklistConstants.brakesKey : brakes,
            PreRideChecklistConstants.batteryKey  : battery,
            PreRideChecklistConstants.tiresKey : tires,
            PreRideChecklistConstants.footPegsKey : footPegs,
            PreRideChecklistConstants.lightSignalKey: lightSignals,
            PreRideChecklistConstants.mirrorsKey: mirrors,
            PreRideChecklistConstants.hornKey: horn,
            PreRideChecklistConstants.motorcycleKey: motorcycle
        ]
    }
    
    init(fluids: Bool, brakes: Bool, battery: Bool, tires: Bool, footPegs: Bool, lightSignals: Bool, mirrors: Bool, horn: Bool, motorcycle: String) {
        self.fluids = fluids
        self.brakes = brakes
        self.battery = battery
        self.tires = tires
        self.footPegs = footPegs
        self.lightSignals = lightSignals
        self.mirrors = mirrors
        self.horn = horn
        self.motorcycle = motorcycle
    }
}

class PreRideChecklistConstants {
    static let fluidsKey = "fluids"
    static let brakesKey = "brakes"
    static let batteryKey = "battery"
    static let tiresKey = "tires"
    static let footPegsKey = "footPegs"
    static let lightSignalKey = "lightSignals"
    static let mirrorsKey = "mirrors"
    static let hornKey = "horn"
    static let motorcycleKey = "motorcycle"
}
