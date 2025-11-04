//
//  OnboardingView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//


import SwiftUI

struct OnboardingView: View {
    let router: AppRouter
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var page = 0

    var body: some View {
        VStack {
            TabView(selection: $page) {
                OBPage(
                    title: "A quick wellness check",
                    text: "Answer a few questions to get a personal mental health score."
                ).tag(0)
                OBPage(
                    title: "Private by default",
                    text: "Signed in anonymously. You control your data."
                ).tag(1)
                OBPage(
                    title: "Help when needed",
                    text: "If your score drops below a threshold, we’ll show specialists."
                ).tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .animation(.easeInOut, value: page)

            HStack(spacing: 12) {
                Button("Skip") { complete() }.buttonStyle(.bordered)
                Button(page < 2 ? "Next" : "Get started") {
                    if page < 2 { page += 1 } else { complete() }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Welcome")
    }

    private func complete() {
        hasSeenOnboarding = true
        router.push(.auth)
    }
}

private struct OBPage: View {
    let title: String; let text: String
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "heart.text.square.fill").font(.system(size: 64))
            Text(title).font(.title2).bold()
            Text(text).multilineTextAlignment(.center).foregroundStyle(.secondary)
            Spacer()
        }
        .padding()
    }
}
