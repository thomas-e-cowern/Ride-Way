//
//  DocumentController.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/15/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation

class DocumentController {
    
    static let shared = DocumentController()
    
    let userId = FirebaseController.shared.userId
    
    func saveNewDocument(name: String, documentationId: String, documentationImageUrl: URL, bikeId: String, completion: @escaping (Documentation?) -> Void) {
        guard let userId = userId else { return }
        let document = Documentation(name: name, bikeId: bikeId, user: userId)
        FirebaseController.shared.saveNewDocument(document: document, completion: completion)
    }
    
    func fetchDocuemnts(bike: String, completion: @escaping ([Documentation]?) -> Void) {
        FirebaseController.shared.fetchDocuments(bike: bike, completion: completion)
    }
    
    func deleteDocument(document: Documentation, completion: @escaping (Bool) -> Void) {
        FirebaseController.shared.deleteDocument(document: document) { (success) in
            if success == true {
                print("deleted document")
                completion(true)
            } else {
                print("Problem deleting document")
                completion(false)
            }
        }
    }
    
    func addImage(data: Data, name: String, bike: String) {
        guard let userId = userId else { return }
        let finalDocument = Documentation(name: name, bikeId: bike, user: userId)
        FirebaseController.shared.uploadImageToFirebaseStorage(document: finalDocument, image: data)
    }
    
    func loadImagages(document: Documentation) {
        guard let userId = userId else { return }
        FirebaseController.shared.downloadImagesFromFirebaseStorage(document: document)
    }
}
