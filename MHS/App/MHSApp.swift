//
//  MHSApp.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//


//import SwiftUI
//
//@main
//struct MHSApp: App {
//    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate  
//    @StateObject private var router = AppRouter()
//
//    var body: some Scene {
//        WindowGroup {
//            NavigationStack(path: $router.path) {
//                SplashView(router: router)
//                    .navigationDestination(for: AppRoute.self) { route in
//                        switch route {
//                        case .auth:
//                            AuthView(router: router)
//                        case .survey:
//                            SurveyView(router: router)
//                        case .results(let result):                           // ✅
//                            ResultsView(router: router, result: result)
//                        case .specialists:                                    // ✅
//                            SpecialistsView(router: router)
//                        }
//                    }
//            }
//        }
//    }
//}


import SwiftUI

@main
struct MHSApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate

    @StateObject private var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SplashView(router: router)
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .auth:
                            AuthView(router: router)
                        case .survey:
                            SurveyView(router: router)
                        case .results(let result):
                            ResultsView(router: router, result: result)
                        case .specialists:
                            SpecialistsView(router: router)
                        case .history:                      
                                HistoryView(router: router)
                        case .settings:
                            SettingsView(router: router)
                        }
                    }
            }
        }
    }
}
