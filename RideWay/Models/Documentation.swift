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
    
    init(name: String, documentationId: String, documentationImage: UIImage, bikeId: String) {
        self.name = name
        self.documentationId = documentationId
        self.documentationImage = documentationImage
        self.bikeId = bikeId
    }
    
    var dictionary: [String: Any] {
        return [
            DocumentationCodingKeys.nameKey : name,
            DocumentationCodingKeys.documentationIdKey : documentationId,
            DocumentationCodingKeys.documentationImageKey : documentationImage,
            DocumentationCodingKeys.bikeIdKey : bikeId
        ]
    }
}

class DocumentationCodingKeys {
    static let nameKey = "name"
    static let documentationIdKey = "documentationId"
    static let documentationImageKey = "documentationImage"
    static let bikeIdKey = "bikeId"
}
