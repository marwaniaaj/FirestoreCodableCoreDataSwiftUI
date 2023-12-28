//
//  Author+CoreDataClass.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import CoreData

extension Author {
    var authorName: String {
        get { name ?? NSLocalizedString("Unavailable", comment: "Unavailable Book") }
        set { name = newValue }
    }

    var booksList: [Book] {
        guard let books else { return [] }
        let allBooks = (books.allObjects as? [Book] ?? [])
        return allBooks.sorted { $0.bookPublishDate < $1.bookPublishDate }
    }

    var booksString: [String] {
        guard let books else { return [] }
        let allBooks = (books.allObjects as? [Book] ?? [])
        return allBooks.map(\.bookTitle)
    }

    var booksIdList: [String]? {
        guard let books else { return nil }
        return (books.allObjects as? [Book])?.compactMap(\.id)
    }
}

extension Author {
    func addBooks(_ books: [Book]?) {
        books?.forEach { book in
            if !self.booksList.contains(book) {
                self.addToBooks(book)
            }
        }
    }
}
