//
//  Book+CoreDataClass.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import CoreData
import FirebaseFirestore

@objc(Book)
public class Book: NSManagedObject, Codable {

    enum CodingKeys: CodingKey {
        case id, title, description, author, numberOfPages, publicationDate, rating, genre
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
        self.title = try? container.decode(String.self, forKey: .title)
        self.titleDescription = try? container.decode(String.self, forKey: .description)

        if let authorDocRef = try? container.decode(DocumentReference.self, forKey: .author) {
            self.author = Author.fetchById(authorDocRef.documentID, context: context)
        }

        self.numberOfPages = try container.decode(Int16.self, forKey: .numberOfPages)
        self.publishDate = try? container.decode(Date.self, forKey: .publicationDate)
        self.rating = try container.decode(Float.self, forKey: .rating)
        self.genre = try? container.decode([String].self, forKey: .genre)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try? container.encode(title, forKey: .title)
        try? container.encode(titleDescription, forKey: .description)
        try? container.encode(numberOfPages, forKey: .numberOfPages)
        try? container.encode(publishDate, forKey: .publicationDate)
        try? container.encode(rating, forKey: .rating)
        try? container.encode(genre, forKey: .genre)

        // Author
        if let authorId = self.author?.id {
            let reference = FirestoreManager.getAuthorDocumentReference(authorId)
            try? container.encode(reference, forKey: .author)
        }
    }
}
