//
//  SettingsView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

//import SwiftUI
//import FirebaseAuth
//
//struct SettingsView: View {
//    let router: AppRouter
//    private let auth: AuthServiceProtocol = AuthService()
//
//    @State private var error: String?
//    @State private var showSignOutConfirm = false
//
//    private var appVersion: String {
//        let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
//        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "—"
//        return "v\(ver) (\(build))"
//    }
//
//    private var uid: String {
//        Auth.auth().currentUser?.uid ?? "Not signed in"
//    }
//
//    var body: some View {
//        List {
//            Section("Account") {
//                HStack {
//                    Text("User ID")
//                    Spacer()
//                    Text(uid).foregroundStyle(.secondary).textSelection(.enabled)
//                }
//                Button(role: .destructive) {
//                    showSignOutConfirm = true
//                } label: {
//                    Text("Sign Out")
//                }
//            }
//
//            Section("About") {
//                HStack {
//                    Text("App Version")
//                    Spacer()
//                    Text(appVersion).foregroundStyle(.secondary)
//                }
//                Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
//            }
//
//            if let error {
//                Section {
//                    Text(error).foregroundStyle(.red)
//                }
//            }
//        }
//        .navigationTitle("Settings")
//        .confirmationDialog("Sign out?",
//            isPresented: $showSignOutConfirm,
//            titleVisibility: .visible
//        ) {
//            Button("Sign Out", role: .destructive) { signOut() }
//            Button("Cancel", role: .cancel) {}
//        }
//    }
//
//    private func signOut() {
//        do {
//            try auth.signOut()
//            // Return to start; Splash will route to Auth again
//            router.popToRoot()
//        } catch {
//            self.error = (error as NSError).localizedDescription
//        }
//    }
//}


import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    let router: AppRouter
    private let auth: AuthServiceProtocol = AuthService()

    // MARK: - App State
    @State private var error: String?
    @State private var showSignOutConfirm = false

    // MARK: - UserDefaults-backed values
    @AppStorage("reminders.enabled") private var remindersEnabled = false
    @AppStorage("ui.colorScheme") private var colorSchemeRaw: String = "system"

    // MARK: - Derived info
    private var appVersion: String {
        let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "—"
        return "v\(ver) (\(build))"
    }

    private var uid: String {
        Auth.auth().currentUser?.uid ?? "Not signed in"
    }

    var body: some View {
        List {
            // MARK: Account Section
            Section("Account") {
                HStack {
                    Text("User ID")
                    Spacer()
                    Text(uid)
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)
                }

                Button(role: .destructive) {
                    showSignOutConfirm = true
                } label: {
                    Text("Sign Out")
                }
            }

            // MARK: Reminders Section
            Section("Reminders") {
                Toggle("Weekly reminder", isOn: Binding(
                    get: { remindersEnabled },
                    set: { newValue in
                        remindersEnabled = newValue
                        Task {
                            if newValue {
                                let ok = await ReminderService.requestPermission()
                                if ok {
                                    try? await ReminderService.scheduleWeekly(weekday: 2, hour: 9)
                                } else {
                                    remindersEnabled = false
                                }
                            } else {
                                await ReminderService.cancelWeekly()
                            }
                        }
                    })
                )
                Text("You’ll receive a gentle Monday 9 AM reminder to check your mental health score.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            // MARK: Appearance Section
            Section("Appearance") {
                Picker("Color Scheme", selection: $colorSchemeRaw) {
                    Text("System").tag("system")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                .pickerStyle(.segmented)
            }

            // MARK: About Section
            Section("About") {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text(appVersion).foregroundStyle(.secondary)
                }

                Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
            }

            if let error {
                Section {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.footnote)
                }
            }
        }
        .navigationTitle("Settings")
        .confirmationDialog(
            "Sign out?",
            isPresented: $showSignOutConfirm,
            titleVisibility: .visible
        ) {
            Button("Sign Out", role: .destructive) { signOut() }
            Button("Cancel", role: .cancel) {}
        }
    }

    // MARK: - Sign Out
    private func signOut() {
        do {
            try auth.signOut()
            router.popToRoot() // Return to Splash
        } catch {
            self.error = (error as NSError).localizedDescription
        }
    }
}
