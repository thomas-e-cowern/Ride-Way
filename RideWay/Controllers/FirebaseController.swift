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
    
    let docRef = Firestore.firestore()
    
    func saveToDatabase(vehicleInfo: VehicleInfo, completion: @escaping (VehicleInfo?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Problem getting userId in saveToDatabase")
            return
        }
        print("💬💬💬💬💬\(vehicleInfo)💬💬💬💬💬")
        vehicleInfo.userId = userId
        let dbref = docRef.collection("bikes").document()
        let uid = dbref.documentID
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
    
//    func saveToDatabase<T: FirebaseObject>(firebaseObject: T, completion: @escaping (T?) -> Void) {
//        let dbref = firebaseObject.documentRef
//        dbref.setData(firebaseObject.dictionary) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//                completion(nil)
//                return
//            } else {
//                completion(firebaseObject)
//                print("Document successfully written!")
//            }
//        }
//    }
//
//    func fetchFromDatabase<T: FirebaseObject>(firebaseObject: T, completion: @escaping ([T?]) -> Void) {
//        let dbref = firebaseObject.documentRef
//        guard let userId = Auth.auth().currentUser?.uid else {
//            print("Problem getting userId in saveToDatabase")
//            return
//        }
//        dbref.collection("").whereField("user", isEqualTo: userId)
//            .getDocuments { (querySnapshot, error) in
//            if let error = error {
//                print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
//                completion([])
//            }
//            if let snapshot = querySnapshot {
//                print(snapshot)
//                //                let data = snapshot.documents.compactMap{ FirebaseObject.init(dictionary: snapshot) }
//                //                print(data)
//                //                completion(data)
//            }
//        }
//    }
    
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
        
//        dbref.getDocument() { (querySnapshot, error) in
//            if let error = error {
//                print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
//                completion([])
//            }
//            if let snapshot = querySnapshot {
//                let data = snapshot.documents.compactMap{ VehicleInfo(dictionary: $0.data()) }
//                print(data)
//                completion(data)
//            }
//        }
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
}
