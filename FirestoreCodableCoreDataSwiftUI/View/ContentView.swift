//
//  ContentView.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var firestore: FirestoreManager
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(sortDescriptors: [SortDescriptor(\.publishDate)], animation: .default)
    private var books: FetchedResults<Book>

    @FetchRequest(sortDescriptors: [], animation: .default)
    private var authors: FetchedResults<Author>

    var body: some View {
        NavigationStack {
            List {
                Section("Books") {
                    ForEach(books) { book in
                        NavigationLink(value: book) {
                            VStack(alignment: .leading) {
                                Text("\(book.bookTitle): \(book.bookTitleDescription)")
                                    .font(.headline)
                                + Text(" by \(book.authorName)")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }

                Section("Authors") {
                    ForEach(authors) { author in
                        VStack(alignment: .leading) {
                            Text(author.authorName)
                                .font(.headline).lineLimit(1)

                            Text(author.booksList, format: .list(type: .and))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookView(book: book)
            }
            .toolbar {
                Button {
                    // TODO: Add book
                    // let book = Book(context: context)
                    // Add properties....
                    //_ = firestore.addBook(book)
                } label: {
                    Label("Add", systemImage: "plus.circle.fill")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
