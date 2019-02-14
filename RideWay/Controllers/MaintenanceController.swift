//
//  MaintenanceController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/13/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class MaintenanceController {
    
    static let shared = MaintenanceController()

    func saveNewMaintenanceRecord(date: Date, location: String, servicePerformed: String, miles: Double, motorcycleId: String, completion: @escaping (Maintenance?) -> Void) {
        let maintenanceRecord = Maintenance(date: date, location: location, servicePerformed: servicePerformed, miles: miles, motorcycle: motorcycleId)
        FirebaseController.shared.saveMaintenenaceRecord(for: maintenanceRecord, completion: completion)
    }
    
    func fetchMaintenanceRecords(completion: @escaping ([Maintenance]?) -> Void) {
        FirebaseController.shared.fetchMaintenenanceRecordsFor(completion: completion)
    }
}
