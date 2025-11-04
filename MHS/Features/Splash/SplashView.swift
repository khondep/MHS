//
//  SplashView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

//import SwiftUI


//struct SplashView: View {
//    let router: AppRouter
//    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
//
//    var body: some View {
//        ZStack {
//            Color.accentColor.ignoresSafeArea()
//            VStack(spacing: 12) {
//                Text("MHS").font(.system(size: 48, weight: .bold)).foregroundStyle(.white)
//                Text("Mental Health Score").foregroundStyle(.white.opacity(0.9))
//            }
//        }
//        .task {
//            try? await Task.sleep(nanoseconds: 750_000_000)
//            router.push(hasSeenOnboarding ? .auth : .onboarding)   // ✅
//        }
//    }
//}



import SwiftUI

struct SplashView: View {
    let router: AppRouter
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    @State private var animate = false

    var body: some View {
        ZStack {
            // Background gradient for more depth
            LinearGradient(
                colors: [Color.teal.opacity(0.9), Color.blue.opacity(0.9)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                // 🧠 Brain icon
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 80))
                    .foregroundStyle(.white)
                    .scaleEffect(animate ? 1.1 : 0.9)
                    .shadow(radius: 10)
                    .animation(
                        .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                        value: animate
                    )

                // App title
                Text("MHS")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(radius: 6)

                Text("Mental Health Score")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .task {
            animate = true
            // Small delay before moving to next screen
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            router.push(hasSeenOnboarding ? .auth : .onboarding)
        }
    }
}
