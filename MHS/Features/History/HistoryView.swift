//
//  HistoryView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

import SwiftUI

struct HistoryView: View {
    let router: AppRouter
    @State private var items: [HistoryItem] = []
    @State private var isLoading = true
    @State private var error: String?
    private let service: HistoryServiceProtocol = HistoryService()

    var body: some View {
        Group {
            if isLoading {
                VStack { ProgressView(); Text("Loading history…").foregroundStyle(.secondary) }
            } else if let error {
                VStack(spacing: 8) {
                    Text("Couldn’t load history").font(.headline)
                    Text(error).font(.subheadline).foregroundStyle(.secondary)
                    Button("Retry") { Task { await load() } }.buttonStyle(.borderedProminent)
                }.padding()
            } else if items.isEmpty {
                ContentUnavailableView("No past results", systemImage: "clock.arrow.circlepath",
                                       description: Text("Complete a survey to see your history here."))
            } else {
                List(items) { item in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(item.scorePercent)%")
                                .font(.title2).bold()
                            Text(dateString(item.createdAt))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if item.flaggedSafety {
                            Label("Safety", systemImage: "exclamationmark.triangle.fill")
                                .labelStyle(.titleAndIcon)
                                .foregroundStyle(.orange)
                                .font(.subheadline)
                        } else if item.scorePercent >= ScoreEngine.healthyThreshold {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "hand.raised.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .navigationTitle("History")
        .task { await load() }
    }

    private func load() async {
        isLoading = true; error = nil
        do {
            items = try await service.listResponses()
            isLoading = false
        } catch {
            isLoading = false
            self.error = (error as NSError).localizedDescription
        }
    }

    private func dateString(_ date: Date?) -> String {
        guard let date else { return "Pending timestamp" }
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f.string(from: date)
    }
}
