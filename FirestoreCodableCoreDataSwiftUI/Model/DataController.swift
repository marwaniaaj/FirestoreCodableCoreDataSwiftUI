//
//  DataController.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import CoreData
import FirebaseFirestore

class DataController: ObservableObject {
    /// The container used to store all our data.
    let container: NSPersistentContainer

    /// Main managed object context.
    var context: NSManagedObjectContext {
        container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "Model")

        // Create a temporary, in-memory database by writing to /dev/null
        // so our data is destroyed after the app finishes running.
        container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }

    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
