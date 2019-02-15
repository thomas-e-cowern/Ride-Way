//
//  FirebaseController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/11/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let shared = FirebaseController()
    
    let userId = Auth.auth().currentUser?.uid
    
    let docRef = Firestore.firestore()
    
    // MARK: - Motorcycles
    func saveToDatabase(vehicleInfo: VehicleInfo, completion: @escaping (VehicleInfo?) -> Void) {

        guard let userId = userId else { return }
        vehicleInfo.userId = userId
        let dbref = docRef.collection("bikes").document(vehicleInfo.uid)
        dbref.setData(vehicleInfo.dictionary) { err in
            if let err = err {
                print("Error writing document: \(err)")
                completion(nil)
                return
            } else {
                completion(vehicleInfo)
                print("Document successfully written!")
            }
        }
    }
    
    func fetchVehiclesFromFirebaseFor(completion: @escaping ([VehicleInfo]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Problem getting userId in saveToDatabase")
            return
        }
        let collection = Firestore.firestore().collection("bikes")
        let query = collection.whereField("userId", isEqualTo: userId)
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                completion([])
            }
            if let snapshot = querySnapshot {
                print(snapshot)
                let data = snapshot.documents.compactMap { VehicleInfo(dictionary: $0.data()) }
                print(data)
                completion(data)
            }
        }
    }
    
    func deleteVehicleFromFirebase(vehicle: VehicleInfo, completion: @escaping (Bool) -> Void) {
        let dbref = docRef.collection("bikes").document(vehicle.uid)
        dbref.delete{ (error) in
            if let error = error {
                print(">>> ❌ There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
                completion(false)
                return
            } else {
                completion(true)
                return
            }
        }
    }
    
//    func updateVehicleInFirebase(vehicle: VehicleInfo, completion: @escaping (Bool) -> Void) {
//        guard let documentId = vehicle.uid else { return }
//        let dbref = docRef.collection("bikes").document(documentId)
//        dbref.updateData(<#T##fields: [AnyHashable : Any]##[AnyHashable : Any]#>)
//    }
    
    // MARK: - Maintenance
    func saveMaintenenaceRecord(for maintenanceRecord: Maintenance, completion: @escaping (Maintenance?) -> Void) {
        guard let userId = userId else { return }
        maintenanceRecord.user = userId
        let dbref = docRef.collection("maintenance").document(maintenanceRecord.maintenanceId)
        dbref.setData(maintenanceRecord.dictionary) { err in
            if let err = err {
                print("Error writing document: \(err)"); completion(nil); return
            } else {
                completion(maintenanceRecord)
                print("Document successfully written!")
            }
        }
    }
    
    func fetchMaintenenanceRecordsFor(completion: @escaping ([Maintenance]?) -> Void) {
        guard let userId = userId else { return }
        let collection = docRef.collection("maintenance")
        let query = collection.whereField("user", isEqualTo: userId)
        query.getDocuments { (querySnapshot, error) in
            if let error = error {print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)"); completion([])}
            if let snapshot = querySnapshot {let data = snapshot.documents.compactMap { Maintenance(dictionary: $0.data()) }; completion(data)}
        }
    }
    
    func deleteMaintenenanceRecordsFor(maintenanceRecord: Maintenance, completion: @escaping (Bool) -> Void) {
        let dbref = docRef.collection("maintenance").document(maintenanceRecord.maintenanceId)
        print("Firebase MaintId: \(maintenanceRecord.maintenanceId)")
        dbref.delete{ (error) in
            if let error = error {
                print(">>> ❌ There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
                completion(false)
                return
            } else {
                print("Firebase should have deleted this maintenance record: \(maintenanceRecord.maintenanceId)")
                completion(true)
                return
            }
        }
    }
    
    // MARK: - Ride Tracking
    func saveNewRide(ride: Rides, completion: @escaping (Rides?) -> Void) {
        guard let userId = userId else { return }
        ride.user = userId
        let dbref = docRef.collection("rides").document(ride.rideId)
        dbref.setData(ride.dictionary) { err in
            if let err = err {
                print("Error writing document: \(err)"); completion(nil); return
            } else {
                completion(ride)
                print("Document successfully written!")
            }
        }
    }
    
    func fetchRides(completion: @escaping ([Rides]?) -> Void) {
        guard let userId = userId else { return }
        let collection = docRef.collection("rides")
        let query = collection.whereField("user", isEqualTo: userId)
        query.getDocuments { (querySnapshot, error) in
            if let error = error {print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)"); completion([])}
            if let snapshot = querySnapshot {let data = snapshot.documents.compactMap { Rides(dictionary: $0.data()) }; completion(data)}
        }
    }
    
    func deleteRide(ride: Rides, completion: @escaping (Bool) -> Void) {
        let dbref = docRef.collection("ride").document(ride.rideId)
        print("Firebase MaintId: \(ride.rideId)")
        dbref.delete{ (error) in
            if let error = error {
                print(">>> ❌ There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
                completion(false)
                return
            } else {
                print("Firebase should have deleted this maintenance record: \(ride.rideId)")
                completion(true)
                return
            }
        }
    }
    
    // MARK: - Parts Tracking
    func saveNewPart(part: Parts, completion: @escaping (Parts?) -> Void) {
        guard let userId = userId else { return }
        part.user = userId
        let dbref = docRef.collection("parts").document(part.partId)
        dbref.setData(part.dictionary) { err in
            if let err = err {
                print("Error writing document: \(err)"); completion(nil); return
            } else {
                completion(part)
                print("Document successfully written!")
            }
        }
    }
    
    func fetchParts(completion: @escaping ([Parts]?) -> Void) {
        guard let userId = userId else { return }
        let collection = docRef.collection("parts")
        let query = collection.whereField("user", isEqualTo: userId)
        query.getDocuments { (querySnapshot, error) in
            if let error = error {print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)"); completion([])}
            if let snapshot = querySnapshot {let data = snapshot.documents.compactMap { Parts(dictionary: $0.data()) }; completion(data)}
        }
    }
    
    func deleteParts(part: Parts, completion: @escaping (Bool) -> Void) {
        let dbref = docRef.collection("parts").document(part.partId)
        dbref.delete{ (error) in
            if let error = error {
                print(">>> ❌ There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
                completion(false)
                return
            } else {
                print("Firebase should have deleted this maintenance record: \(part.partId)")
                completion(true)
                return
            }
        }
    }
}
