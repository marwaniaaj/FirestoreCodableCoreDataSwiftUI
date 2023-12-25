//
//  DecoderError.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import Foundation

enum DecoderError: Error {
    case missingManagedObjectContext
    case missingFirestoreDocumentID
}
