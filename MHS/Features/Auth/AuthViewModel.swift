//
//  AuthViewModel.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//
//
//import Foundation
//
//final class AuthViewModel: ObservableObject {
//    @Published var isLoading = false
//    @Published var error: String?
//
//    private let auth: AuthServiceProtocol
//
//    init(auth: AuthServiceProtocol = AuthService()) {
//        self.auth = auth
//    }
//
//    func signIn(router: AppRouter) {
//        isLoading = true
//        error = nil
//        Task {
//            do {
//                try await auth.signInAnonymously()
//                await MainActor.run {
//                    isLoading = false
//                    router.push(.survey)
//                }
//            } catch {
//                await MainActor.run {
//                    isLoading = false
//                    self.error = "Sign-in failed. Please try again."
//                }
//            }
//        }
//    }
//}


import Foundation
import Combine   // ✅ needed for ObservableObject and @Published

final class AuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: String?

    private let auth: AuthServiceProtocol

    init(auth: AuthServiceProtocol = AuthService()) {
        self.auth = auth
    }

    func signIn(router: AppRouter) {
        isLoading = true
        error = nil
        Task {
            do {
                try await auth.signInAnonymously()
                await MainActor.run {
                    isLoading = false
                    router.push(.survey)
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    self.error = "Sign-in failed. Please try again."
                }
            }
        }
    }
}
