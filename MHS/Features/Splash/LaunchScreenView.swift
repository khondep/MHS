//
//  LaunchScreenView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.teal.opacity(0.8), .blue.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Image("AppLogo") // your new logo asset
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .shadow(radius: 8)
                Text("Mental Health Score")
                    .font(.title2.bold())
                    .foregroundColor(.white)
            }
        }
    }
}
