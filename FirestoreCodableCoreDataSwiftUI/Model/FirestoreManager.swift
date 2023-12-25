//
//  FirestoreManager.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import Foundation
import FirebaseFirestore

/// An environment singleton responsible for cloud firestore operations.
class FirestoreManager: ObservableObject {

    /// Shared firestore.
    var db: Firestore {
        Firestore.firestore()
    }

    private(set) var dataController: DataController!

    init(dataController: DataController) {
        self.dataController = dataController
    }
}

// MARK: - Document References
extension FirestoreManager {
    static func getBooksDocumentReferences(_ ids: [String]) -> [DocumentReference] {
        return ids.compactMap { id in
            return Firestore.firestore().collection("books").document(id)
        }
    }

    static func getAuthorDocumentReference(_ id: String?) -> DocumentReference? {
        if let id, !id.isEmpty {
            return Firestore.firestore().collection("authors").document(id)
        }
        return nil
    }
}
