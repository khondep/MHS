//
//  HelpNowView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

import SwiftUI
import SafariServices

struct HelpNowView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section("If you’re in immediate danger") {
                    Link("Call 911", destination: URL(string: "tel://911")!)
                        .font(.headline)
                }

                Section("24/7 support (United States)") {
                    // Call 988 (Suicide & Crisis Lifeline)
                    Link("Call 988", destination: URL(string: "tel://988")!)
                    // Text 988
                    Link("Text 988", destination: URL(string: "sms:988")!)
                    // Chat (opens in Safari)
                    Link("Chat with 988", destination: URL(string: "https://988lifeline.org/chat/")!)
                }

                Section("General guidance") {
                    Text("Reach out to someone you trust and consider removing anything you could use to harm yourself.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .navigationTitle("Get Help Now")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
