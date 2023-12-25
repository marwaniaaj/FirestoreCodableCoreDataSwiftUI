//
//  Author+CoreDataClass.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import CoreData
import FirebaseFirestore

@objc(Author)
public class Author: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case id, name, website, books
    }

    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw DecoderError.missingManagedObjectContext
        }

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let documentId = try container.decode(DocumentID<String>.self, forKey: .id).wrappedValue

        guard let documentId else  {
            throw DecoderError.missingFirestoreDocumentID
        }

        // Create or update.
        self.init(id: documentId, context: context)

        self.id = documentId
        self.name = try container.decode(String.self, forKey: .name)

        if let booksDocRefArray = try? container.decode([DocumentReference].self, forKey: .books) {
            let bookIds = booksDocRefArray.map(\.documentID)
            self.books = Book.fetchNSSetById(bookIds, context: context)
        }
        self.website = try container.decode(String.self, forKey: .website)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try? container.encode(name, forKey: .name)
        try? container.encode(website, forKey: .website)

        // Books document references
        if let bookIds = (books?.allObjects as? [Book])?.compactMap(\.id) {
            let references = FirestoreManager.getBooksDocumentReferences(bookIds)
            try? container.encode(references, forKey: .books)
        }
    }
}
