//
//  Author+CoreDataClass.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import CoreData

// TODO: Add Codable Author NSManagedObject subclass.

extension Author {
    var authorName: String {
        get { name ?? NSLocalizedString("Unavailable", comment: "Unavailable Book") }
        set { name = newValue }
    }

    var booksListString: String {
        if let books {
            let result = books.allObjects as? [Book] ?? []
            return result.map(\.bookTitle).joined(separator: ", ")
        }
        return NSLocalizedString("Unrecognized", comment: "Unrecognized book")
    }

    var booksList: [String] {
        guard let books else { return [] }
        let allBooks = (books.allObjects as? [Book] ?? [])
        return allBooks.map(\.bookTitle)
    }

    var booksIdList: [String]? {
        guard let books else { return nil }
        return (books.allObjects as? [Book])?.compactMap(\.id)
    }
}
