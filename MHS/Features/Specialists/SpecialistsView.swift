//
//  SpecialistsView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//
//
//import SwiftUI
//
//struct SpecialistsView: View {
//    let router: AppRouter
//    @State private var specialists: [Specialist] = []
//    private let service: SpecialistServiceProtocol = SpecialistService()
//
//    var body: some View {
//        List(specialists) { s in
//            VStack(alignment: .leading, spacing: 4) {
//                Text(s.name).font(.headline)
//                Text(s.specialty).foregroundStyle(.secondary)
//                Text(s.location).foregroundStyle(.secondary)
//                if let url = s.bookingURL {
//                    Link("Book appointment", destination: url)
//                }
//            }
//            .padding(.vertical, 6)
//        }
//        .navigationTitle("Specialists")
//        .task {
//            specialists = await service.listSpecialists()
//        }
//    }
//}

//
//import SwiftUI
//
//struct SpecialistsView: View {
//    let router: AppRouter
//    @State private var specialists: [Specialist] = []
//    @State private var isLoading = true
//    @State private var error: String?
//
//    private let service: SpecialistServiceProtocol = SpecialistService()
//
//    var body: some View {
//        Group {
//            if isLoading {
//                VStack { ProgressView(); Text("Loading specialists…").foregroundStyle(.secondary) }
//            } else if let error {
//                VStack(spacing: 8) {
//                    Text("Couldn’t load specialists").font(.headline)
//                    Text(error).font(.subheadline).foregroundStyle(.secondary)
//                    Button("Retry") { Task { await load() } }.buttonStyle(.borderedProminent)
//                }
//                .padding()
//            } else {
//                List(specialists) { s in
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text(s.name).font(.headline)
//                        Text(s.specialty).foregroundStyle(.secondary)
//                        Text(s.location).foregroundStyle(.secondary)
//                        if let url = s.bookingURL {
//                            Link("Book appointment", destination: url)
//                        }
//                    }
//                    .padding(.vertical, 6)
//                }
//            }
//        }
//        .navigationTitle("Specialists")
//        .task { await load() }
//    }
//
//    private func load() async {
//        isLoading = true
//        error = nil
//        do {
//            specialists = try await service.listSpecialists()
//            isLoading = false
//        } catch {
//            isLoading = false
//            self.error = (error as NSError).localizedDescription
//        }
//    }
//}

//
//
//import SwiftUI
//
//struct SpecialistsView: View {
//    let router: AppRouter
//    @State private var all: [Specialist] = []
//    @State private var query: String = ""
//    @State private var telehealthOnly = false
//    @State private var isLoading = true
//    @State private var error: String?
//
//    private let service: SpecialistServiceProtocol = SpecialistService()
//
//    // Derived list
//    private var filtered: [Specialist] {
//        var items = all
//
//        if telehealthOnly {
//            items = items.filter { $0.acceptsTelehealth }
//        }
//
//        if !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            let q = query.lowercased()
//            items = items.filter {
//                $0.name.lowercased().contains(q) ||
//                $0.specialty.lowercased().contains(q) ||
//                $0.location.lowercased().contains(q)
//            }
//        }
//
//        return items.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
//    }
//
//    var body: some View {
//        Group {
//            if isLoading {
//                VStack { ProgressView(); Text("Loading specialists…").foregroundStyle(.secondary) }
//            } else if let error {
//                VStack(spacing: 8) {
//                    Text("Couldn’t load specialists").font(.headline)
//                    Text(error).font(.subheadline).foregroundStyle(.secondary)
//                    Button("Retry") { Task { await load() } }.buttonStyle(.borderedProminent)
//                }
//                .padding()
//            } else if filtered.isEmpty {
//                ContentUnavailableView("No matches",
//                    systemImage: "magnifyingglass",
//                    description: Text("Try a different name, specialty, or location.")
//                )
//            } else {
//                List(filtered) { s in
//                    VStack(alignment: .leading, spacing: 6) {
//                        HStack {
//                            Text(s.name).font(.headline)
//                            if s.acceptsTelehealth {
//                                Label("Telehealth", systemImage: "video.fill")
//                                    .font(.caption)
//                                    .foregroundStyle(.blue)
//                                    .padding(.horizontal, 6)
//                                    .padding(.vertical, 3)
//                                    .background(.blue.opacity(0.1), in: Capsule())
//                            }
//                        }
//                        Text(s.specialty).foregroundStyle(.secondary)
//                        Text(s.location).foregroundStyle(.secondary)
//                        if let url = s.bookingURL {
//                            Link("Book appointment", destination: url)
//                        }
//                    }
//                    .padding(.vertical, 6)
//                }
//            }
//        }
//        .navigationTitle("Specialists")
//        .toolbar {
//            ToolbarItemGroup(placement: .topBarTrailing) {
//                Toggle(isOn: $telehealthOnly) {
//                    Image(systemName: "video.fill")
//                }
//                .toggleStyle(.switch)
//                .help("Show telehealth only")
//            }
//        }
//        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search name, specialty, or location")
//        .task { await load() }
//    }
//
//    private func load() async {
//        isLoading = true
//        error = nil
//        do {
//            all = try await service.listSpecialists()
//            isLoading = false
//        } catch {
//            isLoading = false
//            self.error = (error as NSError).localizedDescription
//        }
//    }
//}



import SwiftUI

struct SpecialistsView: View {
    let router: AppRouter

    // ✅ Persisted across launches
    @AppStorage("specialists.query") private var query: String = ""
    @AppStorage("specialists.telehealthOnly") private var telehealthOnly: Bool = false

    @State private var all: [Specialist] = []
    @State private var isLoading = true
    @State private var error: String?

    private let service: SpecialistServiceProtocol = SpecialistService()

    private var filtered: [Specialist] {
        var items = all
        if telehealthOnly { items = items.filter { $0.acceptsTelehealth } }
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if !q.isEmpty {
            items = items.filter {
                $0.name.lowercased().contains(q) ||
                $0.specialty.lowercased().contains(q) ||
                $0.location.lowercased().contains(q)
            }
        }
        return items.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }

    var body: some View {
        Group {
            if isLoading {
                VStack { ProgressView(); Text("Loading specialists…").foregroundStyle(.secondary) }
            } else if let error {
                VStack(spacing: 8) {
                    Text("Couldn’t load specialists").font(.headline)
                    Text(error).font(.subheadline).foregroundStyle(.secondary)
                    Button("Retry") { Task { await load() } }.buttonStyle(.borderedProminent)
                }
                .padding()
            } else if filtered.isEmpty {
                ContentUnavailableView("No matches",
                    systemImage: "magnifyingglass",
                    description: Text("Try a different name, specialty, or location.")
                )
            } else {
                List(filtered) { s in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(s.name).font(.headline)
                            if s.acceptsTelehealth {
                                Label("Telehealth", systemImage: "video.fill")
                                    .font(.caption)
                                    .foregroundStyle(.blue)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(.blue.opacity(0.1), in: Capsule())
                            }
                        }
                        Text(s.specialty).foregroundStyle(.secondary)
                        Text(s.location).foregroundStyle(.secondary)
                        if let url = s.bookingURL {
                            Link("Book appointment", destination: url)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .navigationTitle("Specialists")
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Toggle(isOn: $telehealthOnly) {
                    Image(systemName: "video.fill")
                }
                .toggleStyle(.switch)
                .help("Show telehealth only")
            }
        }
        .searchable(
            text: $query,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search name, specialty, or location"
        )
        .task { await load() }
    }

    private func load() async {
        isLoading = true
        error = nil
        do {
            all = try await service.listSpecialists()
            isLoading = false
        } catch {
            isLoading = false
            self.error = (error as NSError).localizedDescription
        }
    }
}
