//
//  BookView.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import SwiftUI

struct BookView: View {
    @ObservedObject var book: Book
    @EnvironmentObject var firestore: FirestoreManager

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(book.bookTitle): \(book.bookTitleDescription)")
                .font(.headline)
            + Text(" by \(book.authorName)")
                .foregroundStyle(.secondary)

            Text("Published: ").foregroundStyle(.blue)
            + Text(book.bookPublishDate, style: .date)

            if !book.genreList.isEmpty {
                VStack {
                    Text("Genre: ").font(.headline).foregroundStyle(.blue)
                    + Text(book.genreList, format: .list(type: .and))
                }
            }

            Text("Number of Pages: \(book.numberOfPages)")
            Text("Rating: \(String(format: "%.2f", book.rating))")

            Spacer()
        }
        .padding()
        .navigationTitle(book.bookTitle)
        .toolbar {
            Button {
                // TODO: Update book
                //_ = firestore.updateBook(book)
            } label: {
                Label("Add", systemImage: "square.and.pencil")
            }
        }
    }
}
