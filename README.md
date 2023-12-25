#  Firestore and Codable NSManagedObject subclass in SwiftUI

> Sample app to demonstrate how to encode/decode [Firestore](https://firebase.google.com/docs/firestore) document data to Core Data `NSManagedObject` subclass using `Codable` API, and use `@FetchRequest` to display data in SwiftUI views.


## Project overview
Since Firestore's support for Swift's Codable API, it became easier to map Firestore data to any object that conforms to Codable protocol, but `NSManagedObject` subclass does not conform to `Codable`, and we have to do that manually.


### Medium Article:
[Firestore and Codable Core Data NSManagedObject in SwiftUI](https://medium.com/p/ad9ae5f4eae8/edit)


## References
- [Mapping Firestore Data in Swift - The Comprehensive Guide](https://medium.com/firebase-developers/mapping-firestore-data-in-swift-the-comprehensive-guide-36ad05fb8109)
- [Using Codable with Core Data and NSManagedObject](https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/)
- [Working with Codable and Core Data](https://medium.com/@andrea.prearo/working-with-codable-and-core-data-83983e77198e)
- [@DocumentID not populated with custom codable implementation](https://github.com/firebase/firebase-ios-sdk/issues/7242)
- [Update CoreData in init(from:)](https://stackoverflow.com/questions/67044602/core-data-doesnt-update-related-objects/67085696#67085696)

## Build and Install

### Requirements:
- iOS 16.6+
- Xcode 15
- Swift 5.9
