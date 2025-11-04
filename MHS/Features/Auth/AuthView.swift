//
//  AuthView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

//
//import SwiftUI
//
//struct AuthView: View {
//    let router: AppRouter
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("Welcome").font(.largeTitle).bold()
//            Text("Sign in to start your brief mental health check.")
//                .multilineTextAlignment(.center)
//                .foregroundStyle(.secondary)
//            Button("Continue") {
//                router.push(.survey)
//            }
//            .buttonStyle(.borderedProminent)
//        }
//        .padding()
//        .navigationTitle("Sign In")
//    }
//}

import SwiftUI

struct AuthView: View {
    let router: AppRouter
    @StateObject private var vm = AuthViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome").font(.largeTitle).bold()
            Text("Sign in to start your brief mental health check.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button {
                vm.signIn(router: router)
            } label: {
                if vm.isLoading {
                    ProgressView()
                } else {
                    Text("Continue")
                }
            }
            .buttonStyle(.borderedProminent)

            if let err = vm.error {
                Text(err).foregroundStyle(.red)
            }
        }
        .padding()
        .navigationTitle("Sign In")
    }
}
