//
//  FirebaseAppDelegate.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//
//import SwiftUI
//import FirebaseCore
//
//final class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
//    ) -> Bool {
//        FirebaseApp.configure()
//        
//        return true
//    }
//}

//
//  FirebaseAppDelegate.swift
//  MHS
//
//
//import SwiftUI
//import FirebaseCore
//
//#if DEBUG
//import FirebaseFirestore
//import FirebaseAuth
//#endif
//
//final class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
//    ) -> Bool {
//        FirebaseApp.configure()
//
//        #if DEBUG
//        // Point to local emulators in Debug builds
//        let db = Firestore.firestore()
//        db.useEmulator(withHost: "localhost", port: 8080)
//        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
//        #endif
//
//        return true
//    }
//}

//
//import SwiftUI
//import FirebaseCore
//
//#if DEBUG
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseAppCheck
//#endif
//
//final class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
//    ) -> Bool {
//
//        #if DEBUG
//        // Use App Check Debug provider in Debug to avoid "DeviceCheckProvider unsupported" warnings on Simulator.
//        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
//        #endif
//
//        FirebaseApp.configure()
//
//        #if DEBUG
//        // Point SDKs to local emulators in Debug builds.
//        // You can flip this to false to hit production while still in Debug.
//        let useEmulators = true
//
//        if useEmulators {
//            // Firestore emulator
//            Firestore.firestore().useEmulator(withHost: "localhost", port: 8080)
//            // Auth emulator
//            Auth.auth().useEmulator(withHost: "localhost", port: 9099)
//        }
//        #endif
//
//        return true
//    }
//}



import SwiftUI
import FirebaseCore

#if DEBUG
import FirebaseAuth
import FirebaseFirestore
// Optional: quiet App Check warning locally
import FirebaseAppCheck
#endif

final class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        #if DEBUG
        // Optional: silence App Check warnings locally
        // Comment out if you don't have FirebaseAppCheck added.
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        #endif

        FirebaseApp.configure()

        #if DEBUG
        // ---- Firestore emulator (explicitly disable SSL) ----
        let db = Firestore.firestore()
        db.useEmulator(withHost: "127.0.0.1", port: 8080)

        // Extra belt-and-suspenders: ensure SSL is OFF
        let settings = db.settings
        settings.isSSLEnabled = false
        db.settings = settings

        // ---- Auth emulator ----
        Auth.auth().useEmulator(withHost: "127.0.0.1", port: 9099)
        #endif

        return true
    }
}
