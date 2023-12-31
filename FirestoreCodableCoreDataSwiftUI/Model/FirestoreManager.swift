//
//  FirestoreManager.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import FirebaseFirestore

/// An environment singleton responsible for cloud firestore operations.
class FirestoreManager: ObservableObject {

    /// Shared firestore.
    var db: Firestore {
        Firestore.firestore()
    }

    /// ``Firestore.Decoder`` instance with ``NSManagerObjectContext`` stored in ``userInfo`` dictionary.
    var decoder: Firestore.Decoder {
        let decoder = Firestore.Decoder()
        decoder.userInfo[.context] = dataController.context
        return decoder
    }

    private(set) var dataController: DataController!

    init(dataController: DataController) {
        self.dataController = dataController
        booksObserver()
        authorsObserver()
    }
}

// MARK: - Books
extension FirestoreManager {

    /// Register observer on ``Book`` documents.
    func booksObserver() {
        _ = db.collection("books").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print("FirestoreError: failed to fetch books snapshot, \(error!)")
                return
            }

            do {
                let books = try snapshot.documents.map {
                    let book = try $0.data(as: Book.self, decoder: self.decoder)
                    return book
                }
                print("Books: \(books)")
            }
            catch {
                print("FirestoreError: Failed to get books documents. \(error)")
            }
        }
    }

    /// Add document in `books` collection in Firestore encoded from given ``Book``.
    /// - Parameter book: ``Book`` object to be stored in Firestore.
    /// - Returns: Boolean indicates whether document was successfully added or not.
    func addBook(_ book: Book) -> Bool {
        do {
            try db.collection("books").addDocument(from: book)
            return true
        }
        catch {
            print("FirestoreError: Failed to update book. \(error)")
        }
        return false
    }
    
    /// Update existing `book` document in Firestore with encoded data from given ``Book``.
    /// - Parameter book: ``Book`` object to be updated in Firestore.
    /// - Returns: Boolean indicates whether document was successfully added or not.
    func updateBook(_ book: Book) -> Bool {
        guard let documentId = book.id else { return false }
        do {
            try db.collection("books").document(documentId).setData(from: book, merge: true)
            return true
        }
        catch {
            print("FirestoreError: Failed to update book. \(error)")
        }
        return false
    }
}

// MARK: - Author
extension FirestoreManager{

    /// Register observer on ``Author`` documents.
    func authorsObserver() {
        _ = db.collection("authors").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print("FirestoreError: failed to fetch authors snapshot, \(error!)")
                return
            }

            do {
                let authors = try snapshot.documents.map {
                    let author = try $0.data(as: Author.self, decoder: self.decoder)
                    return author
                }
                print("Authors: \(authors)")
            }
            catch {
                print("FirestoreError: Failed to get authors documents. \(error)")
            }
        }
    }

    /// Add document in `authors` collection in Firestore encoded from given ``Author``.
    /// - Parameter author: ``Author`` object to be stored in Firestore.
    /// - Returns: Boolean indicates whether document was successfully added or not.
    func addAuthor(_ author: Author) -> Bool {
        do {
            try db.collection("authors").addDocument(from: author)
            return true
        }
        catch {
            print("FirestoreError: Failed to update author. \(error)")
        }
        return false
    }

    /// Update existing `author` document in Firestore with encoded data from given ``Author``.
    /// - Parameter author: ``Author`` object to be updated in Firestore.
    /// - Returns: Boolean indicates whether document was successfully added or not.
    func updateAuthor(_ author: Author) -> Bool {
        guard let documentId = author.id else { return false }
        do {
            try db.collection("authors").document(documentId).setData(from: author, merge: true)
            return true
        }
        catch {
            print("FirestoreError: Failed to update book. \(error)")
        }
        return false
    }
}

// MARK: - Document References
extension FirestoreManager {

    /// Get an array of book `DocumentReference`.
    /// - Parameter ids: Array of books DocumentIDs.
    /// - Returns: Array of `DocumentReference` for given ids.
    static func getBooksDocumentReferences(_ ids: [String]) -> [DocumentReference] {
        return ids.compactMap { id in
            return Firestore.firestore().collection("books").document(id)
        }
    }
    
    /// Get author `DocumentReference`.
    /// - Parameter id: Author DocumentID.
    /// - Returns: `DocumentReference` of given authorId.
    static func getAuthorDocumentReference(_ id: String?) -> DocumentReference? {
        if let id, !id.isEmpty {
            return Firestore.firestore().collection("authors").document(id)
        }
        return nil
    }
}
