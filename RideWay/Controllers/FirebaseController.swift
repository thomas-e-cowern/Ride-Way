//
//  FirebaseController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/11/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseController {
    
    static let shared = FirebaseController()
    
    let userId = Auth.auth().currentUser?.uid
    
    let docRef = Firestore.firestore()
    
    let storageRef = Storage.storage().reference()
    
    let documentRef = Storage.storage()
    
    // MARK: - Motorcycles
    func saveToDatabase(vehicleInfo: VehicleInfo, completion: @escaping (VehicleInfo?) -> Void) {
        vehicleInfo.bikePhotoUrlString = "gs://ride-way.appspot.com/photos/\(vehicleInfo.userId)/\(vehicleInfo.uid)/\(vehicleInfo.model)"
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
    
    func saveBikePic(bike: VehicleInfo, image: Data) {
        print("attempting to upload an image")
        let bikeStorageRef = storageRef.child("photos/\(bike.userId)/\(bike.uid)").child(bike.model)
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpg"
        bikeStorageRef.putData(image as Data, metadata: uploadMetaData) { (metadata, error) in
            if (error != nil) {
                print("recieved an error: \(String(describing: error?.localizedDescription))")
            } else {
                print("upload complete! \(String(describing: metadata))")
                let bikePhotoRef = self.storageRef.child("photos/\(bike.userId)/\(bike.uid)").child(bike.model)
                
                print(bikePhotoRef)
            }
        }
        saveToDatabase(vehicleInfo: bike) { (success) in
            
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
    
    func fetchMaintenenanceRecordsFor(bike: String, completion: @escaping ([Maintenance]?) -> Void) {
        guard let userId = userId else { return }
        let collection = docRef.collection("maintenance")
        let query = collection.whereField("user", isEqualTo: userId).whereField("motorcycle", isEqualTo: bike)
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
    
    
    // DHS2J39bzQRouwryF4b2fomwjfr1
    func fetchRides(bike: String, completion: @escaping ([Rides]?) -> Void) {
        print("Inside fetchRides FC")
        guard let userId = userId else { return }
        let collection = docRef.collection("rides")
        let query = collection.whereField("user", isEqualTo: userId).whereField("bikeId", isEqualTo: bike)
        query.getDocuments { (querySnapshot, error) in
            print("inside getDocuments")
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
    
    func fetchParts(bike: String, completion: @escaping ([Parts]?) -> Void) {
        guard let userId = userId else { return }
        let collection = docRef.collection("parts")
        let query = collection.whereField("user", isEqualTo: userId).whereField("bikeId", isEqualTo: bike)
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
    
    // MARK: - Documentation
    func saveNewDocument(document: Documentation, completion: @escaping (Documentation?) -> Void) {
        document.documentationImageUrl = "gs://ride-way.appspot.com/photos/\(document.user)/\(document.bikeId)/\(document.name)"
        let dbref = docRef.collection("documentation").document(document.documentationId)
        dbref.setData(document.dictionary) { err in
            if let err = err {
                print("Error writing document: \(err)"); completion(nil); return
            } else {
                completion(document)
                print("Document successfully written!")
            }
        }
    }
    
    func fetchDocuments(bike: String, completion: @escaping ([Documentation]?) -> Void) {
        guard let userId = userId else { return }
        
        let collection = docRef.collection("documentation")
        let query = collection.whereField("userr", isEqualTo: userId).whereField("bikeId", isEqualTo: bike)
        query.getDocuments { (querySnapshot, error) in
            if let error = error {print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)"); completion([])}
            if let snapshot = querySnapshot {let data = snapshot.documents.compactMap { Documentation(dictionary: $0.data()) }; completion(data)}
        }
    }
    
    func deleteDocument(document: Documentation, completion: @escaping (Bool) -> Void) {
        let dbref = docRef.collection("documentation").document(document.documentationId)
        dbref.delete{ (error) in
            if let error = error {
                print(">>> ❌ There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
                completion(false)
                return
            } else {
                print("Firebase should have deleted this document: \(document.documentationId)")
                completion(true)
                return
            }
        }
    }
    
    func uploadImageToFirebaseStorage(document: Documentation, image: Data) {
        print("attempting to upload an image")
        let bikeStorageRef = storageRef.child("photos/\(document.user)/\(document.bikeId)").child(document.name)
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpg"
        bikeStorageRef.putData(image as Data, metadata: uploadMetaData) { (metadata, error) in
            if (error != nil) {
                print("recieved an error: \(String(describing: error?.localizedDescription))")
            } else {
                print("upload complete! \(String(describing: metadata))")
                let bikePhotoRef = self.storageRef.child("photos/\(document.user)/\(document.bikeId)/\(document.name)")
                
                print(bikePhotoRef)
            }
        }
        saveNewDocument(document: document) { (success) in
            
        }
    }
    
    func downloadImagesFromFirebaseStorage(url: String, commpletion: @escaping (UIImage) -> Void) {
        print("attempting to download images")
        let imgUrl = documentRef.reference(forURL: url)
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imgUrl.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("😡 There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
                commpletion(UIImage())
                return
            } else {
                // Data for "images/island.jpg" is returned
                guard let image = UIImage(data: data!) else { return }
                print(image.size)
                commpletion(image)
                return
            }
        }
    }
}
