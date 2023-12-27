//
//  Book+CoreDataClass.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import CoreData

extension Book {
    var bookTitle: String {
        get { title ?? NSLocalizedString("Unavailable", comment: "Unavailable Book") }
        set { title = newValue }
    }

    var bookTitleDescription: String {
        get { titleDescription ?? NSLocalizedString("Unavailable", comment: "Unavailable Book") }
        set { titleDescription = newValue }
    }

    var authorName: String {
        author?.authorName ?? "N/A"
    }

    var bookPublishDate: Date {
        publishDate ?? .now
    }

    var genreList: [String] {
        return genre ?? []
    }
}
