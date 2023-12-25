//
//  Extensions.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import CoreData

public extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension Identifiable where Self: NSManagedObject {

    init(id: String, context: NSManagedObjectContext) {

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Self.classForCoder()))
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1

        var object: Self? = nil
        context.performAndWait {
            if let result = (try? context.execute(request) as? NSAsynchronousFetchResult<Self>)?.finalResult?.first {
                object = result
            }
        }

        if let object {
            self = object
            return
        }

        self.init(context: context)
    }

    func fetchById<T: NSManagedObject>(entity: T.Type, id: String, context: NSManagedObjectContext) -> T? {
        let request = T.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return try? context.fetch(request).first as? T
    }

    static func fetchById(_ id: String, context: NSManagedObjectContext) -> Self? {
        let request = Self.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return try? context.fetch(request).first as? Self
    }

    static func fetchNSSetById(_ ids: [String], context: NSManagedObjectContext) -> NSSet? {
        let request = Self.fetchRequest()
        request.predicate = NSPredicate(format: "id IN %@", ids)
        if let result = try? context.fetch(request) as? [Self] {
            return NSSet(array: result)
        }
        return nil
    }
}
