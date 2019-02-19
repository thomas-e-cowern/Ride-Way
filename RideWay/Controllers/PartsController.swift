//
//  PartsController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/14/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class PartsController {
    
    static let shared = PartsController()
    
    let userId = FirebaseController.shared.userId
    
    func saveNewPart(name: String, number: String, serialNumber: String, description: String, cost: Double, bikeId: String, completion: @escaping (Parts?) -> Void) {
        guard let userId = userId else { return }
        let part = Parts(name: name, number: number, serialNumber: serialNumber, description: description, cost: cost, bikeId: bikeId, user: userId)
        FirebaseController.shared.saveNewPart(part: part, completion: completion)
    }
    
    func fetchParts(bike: String, completion: @escaping ([Parts   ]?) -> Void) {
        FirebaseController.shared.fetchParts(bike: bike, completion: completion)
    }
    
    func deletePart(part: Parts, completion: @escaping (Bool) -> Void) {
        FirebaseController.shared.deleteParts(part: part) { (success) in
            if success == true {
                print("deleted part")
                completion(true)
            } else {
                print("Problem deleting part")
                completion(false)
            }
        }
    }
}
