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
    
    let userId = FirebaseController.shared.userId

    func saveNewMaintenanceRecord(date: Date, location: String, servicePerformed: String, miles: Double, motorcycleId: String, completion: @escaping (Maintenance?) -> Void) {
        guard let userId = userId else { return }
        let maintenanceRecord = Maintenance(date: date, location: location, servicePerformed: servicePerformed, miles: miles, motorcycle: motorcycleId, user: userId)
        FirebaseController.shared.saveMaintenenaceRecord(for: maintenanceRecord, completion: completion)
    }
    
    func fetchMaintenanceRecords(completion: @escaping ([Maintenance]?) -> Void) {
        FirebaseController.shared.fetchMaintenenanceRecordsFor(completion: completion)
    }
    
    func deleteMaintenance(record: Maintenance, completion: @escaping (Bool) -> Void) {
        FirebaseController.shared.deleteMaintenenanceRecordsFor(maintenanceRecord: record) { (success) in
            if success == true {
                print("deleted maintenancdRecord")
                completion(true)
            } else {
                print("problem deleting maintenancdRecord")
                completion(false)
            }
        }
    }
}
