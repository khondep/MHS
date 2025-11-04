//
//  Background.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

import SwiftUI

struct SoftGradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                colors: [Color.accentColor.opacity(0.12), .clear],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            content
        }
    }
}
extension View {
    func softBackground() -> some View { modifier(SoftGradientBackground()) }
}
