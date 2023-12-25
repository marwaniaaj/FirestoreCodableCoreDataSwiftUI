//
//  FirestoreCodableCoreDataSwiftUIApp.swift
//  FirestoreCodableCoreDataSwiftUI
//
//  Created by Marwa Abou Niaaj on 25/12/2023.
//

import FirebaseCore
import SwiftUI

@main
struct FirestoreCodableCoreDataSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var dataController: DataController
    @StateObject var firestoreManager: FirestoreManager

    init() {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)

        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)

        let firestoreManager = FirestoreManager(dataController: dataController)
        _firestoreManager = StateObject(wrappedValue: firestoreManager)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.context)
                .environmentObject(dataController)
                .environmentObject(firestoreManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

