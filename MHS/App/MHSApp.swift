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

//
//import SwiftUI
//
//@main
//struct MHSApp: App {
//    // Register app delegate for Firebase setup
//    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate
//
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
//                        case .results(let result):
//                            ResultsView(router: router, result: result)
//                        case .specialists:
//                            SpecialistsView(router: router)
//                        case .history:                      
//                                HistoryView(router: router)
//                        case .settings:
//                            SettingsView(router: router)
//                        }
//                    }
//            }
//        }
//    }
//}



import SwiftUI

@main
struct MHSApp: App {
    // Firebase setup
    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var delegate

    // Router
    @StateObject private var router = AppRouter()

    // Appearance preference (from SettingsView)
    @AppStorage("ui.colorScheme") private var colorSchemeRaw: String = "system"

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SplashView(router: router)
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .onboarding:
                            OnboardingView(router: router)
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
            .preferredColorScheme(resolveColorScheme(colorSchemeRaw))
        }
    }

    private func resolveColorScheme(_ raw: String) -> ColorScheme? {
        switch raw {
        case "light": return .light
        case "dark":  return .dark
        default:      return nil // system
        }
    }
}
