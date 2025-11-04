//
//  SplashView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

import SwiftUI

struct SplashView: View {
    let router: AppRouter
    
    var body: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack(spacing: 12) {
                Text("MHS")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(.white)
                Text("Mental Health Score")
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .task {
            // Tiny delay to show the splash, then go to Auth
            try? await Task.sleep(nanoseconds: 800_000_000)
            router.push(.auth)
        }
    }
}
