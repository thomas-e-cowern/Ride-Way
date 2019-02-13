//
//  FirebaseObject.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/12/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import Foundation
import Firebase

protocol FirebaseObject {
    static var collectionName: String { get }
    var uid: String { get }
    var dictionary: [String : Any] { get }
    init?(dictionary: [String : Any])
}

extension FirebaseObject {
    var collectionRef: CollectionReference {
        return Firestore.firestore().collection(Self.collectionName)
    }
    
    var documentRef: DocumentReference {
        return collectionRef.document(uid)
    }
}
