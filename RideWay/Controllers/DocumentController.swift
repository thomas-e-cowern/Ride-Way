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
    
    func addImage(data: NSData, name: String, bike: String) {
        guard let userId = userId else { return }
        FirebaseController.shared.uploadImageToFirebaseStorage(data: data as NSData, name: name, bike: bike, user: userId)
    }
    
}
