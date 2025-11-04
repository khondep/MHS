//
//  SettingsView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    let router: AppRouter
    private let auth: AuthServiceProtocol = AuthService()

    @State private var error: String?
    @State private var showSignOutConfirm = false

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
            Section("Account") {
                HStack {
                    Text("User ID")
                    Spacer()
                    Text(uid).foregroundStyle(.secondary).textSelection(.enabled)
                }
                Button(role: .destructive) {
                    showSignOutConfirm = true
                } label: {
                    Text("Sign Out")
                }
            }

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
                    Text(error).foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Settings")
        .confirmationDialog("Sign out?",
            isPresented: $showSignOutConfirm,
            titleVisibility: .visible
        ) {
            Button("Sign Out", role: .destructive) { signOut() }
            Button("Cancel", role: .cancel) {}
        }
    }

    private func signOut() {
        do {
            try auth.signOut()
            // Return to start; Splash will route to Auth again
            router.popToRoot()
        } catch {
            self.error = (error as NSError).localizedDescription
        }
    }
}
