//
//  AuthService.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

//import Foundation
//import FirebaseAuth
//
//protocol AuthServiceProtocol {
//    var isAuthenticated: Bool { get }
//    func signInAnonymously() async throws
//}
//
//final class AuthService: AuthServiceProtocol {
//    var isAuthenticated: Bool {
//        Auth.auth().currentUser != nil
//    }
//
//    func signInAnonymously() async throws {
//        if Auth.auth().currentUser != nil { return } // already signed in
//        _ = try await Auth.auth().signInAnonymously()
//    }
//}


import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    var isAuthenticated: Bool { get }
    func signInAnonymously() async throws
    func signOut() throws                      // ✅ add
}

final class AuthService: AuthServiceProtocol {
    var isAuthenticated: Bool { Auth.auth().currentUser != nil }

    func signInAnonymously() async throws {
        if Auth.auth().currentUser != nil { return }
        _ = try await Auth.auth().signInAnonymously()
    }

    func signOut() throws {                    // ✅ add
        try Auth.auth().signOut()
    }
}
