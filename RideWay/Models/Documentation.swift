//
//  Documentation.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/13/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation
import UIKit

class Documentation {
    var name: String
    var documentationId: String
    var documentationImage: UIImage
    var bikeId: String
    var user: String

    
    init(name: String, documentationId: String = UUID().uuidString, documentationImage: UIImage, bikeId: String, user: String) {
        self.name = name
        self.documentationId = documentationId
        self.documentationImage = documentationImage
        self.bikeId = bikeId
        self.user = user
    }
    
    var dictionary: [String: Any] {
        return [
            DocumentationCodingKeys.nameKey : name,
            DocumentationCodingKeys.documentationIdKey : documentationId,
            DocumentationCodingKeys.documentationImageKey : documentationImage,
            DocumentationCodingKeys.bikeIdKey : bikeId,
            DocumentationCodingKeys.userKey : user
        ]
    }
    
    required convenience init?(dictionary: [String : Any]) {
        guard let name = dictionary[DocumentationCodingKeys.nameKey] as? String,
            let documentationId = dictionary[DocumentationCodingKeys.documentationIdKey] as? String,
            let documentationImage = dictionary[DocumentationCodingKeys.documentationImageKey] as? UIImage,
            let bikeId = dictionary[DocumentationCodingKeys.bikeIdKey] as? String,
            let user = dictionary[DocumentationCodingKeys.userKey] as? String
            else { return nil }
        self.init(name: name, documentationId: documentationId, documentationImage: documentationImage, bikeId: bikeId, user: user)
    }
}

class DocumentationCodingKeys {
    static let nameKey = "name"
    static let documentationIdKey = "documentationId"
    static let documentationImageKey = "documentationImage"
    static let bikeIdKey = "bikeId"
    static let userKey = "userr"

}
