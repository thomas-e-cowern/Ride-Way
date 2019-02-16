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
        let document = Documentation(name: name, documentationId: documentationId, documentationImageUrl: documentationImageUrl, bikeId: bikeId, user: userId)
        FirebaseController.shared.saveNewDocument(document: document, completion: completion)
    }
    
    func fetchDocuemnts(completion: @escaping ([Documentation]?) -> Void) {
        FirebaseController.shared.fetchDocuments(completion: completion)
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
    
    func addImage(data: NSData, name: String, bike: String) {
        guard let userId = userId else { return }
        let finalDocument = Documentation(name: name, documentationImage: data, bikeId: bike, user: userId)
        FirebaseController.shared.uploadImageToFirebaseStorage(document: finalDocument, name: name)
    }
    
    func loadImagages(document: Documentation) {
        guard let userId = userId else { return }
        FirebaseController.shared.downloadImagesFromFirebaseStorage(document: document)
    }
}
