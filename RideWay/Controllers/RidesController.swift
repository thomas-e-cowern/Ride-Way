//
//  RidesController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/14/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class RidesController {
    
    static let shared = RidesController()
    
    let userId = FirebaseController.shared.userId
    
    func saveNewRide(startDate: Date, endDate: Date, mileageStart: Double, mileageEnd: Double, notes: String, completion: @escaping (Rides?) -> Void) {
        guard let userId = userId else { return }
        let ride = Rides(startDate: startDate, endDate: endDate, mileageStart: mileageStart, mileageEnd: mileageEnd, notes: notes, user: userId)
        FirebaseController.shared.saveNewRide(ride: ride, completion: completion)
    }
    
    func fetchRides(completion: @escaping ([Rides]?) -> Void) {
        FirebaseController.shared.fetchRides(completion: completion)
    }
    
    func deleteRide(ride: Rides, completion: @escaping (Bool) -> Void) {
        FirebaseController.shared.deleteRide(ride: ride) { (success) in
            if success == true {
                print("deleted ride")
                completion(true)
            } else {
                print("Problem deleting ride")
                completion(false)
            }
        }
    }
}
