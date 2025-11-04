//
//  HistoryService.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

import Foundation

protocol HistoryServiceProtocol {
    func listResponses() async throws -> [HistoryItem]
}

final class HistoryService: HistoryServiceProtocol {
    func listResponses() async throws -> [HistoryItem] {
        #if canImport(FirebaseFirestore)
        return try await fetchFromFirestore()
        #else
        // Fallback stub
        return [
            .init(id: "stubA", scorePercent: 62, flaggedSafety: false, createdAt: Date()),
            .init(id: "stubB", scorePercent: 78, flaggedSafety: false, createdAt: Date().addingTimeInterval(-86400))
        ]
        #endif
    }
}

#if canImport(FirebaseFirestore)
import FirebaseAuth
import FirebaseFirestore

private extension HistoryService {
    func fetchFromFirestore() async throws -> [HistoryItem] {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "HistoryService", code: 401, userInfo: [NSLocalizedDescriptionKey: "No authenticated user"])
        }
        let db = Firestore.firestore()
        // Order by createdAt desc; recent writes may have nil until server timestamp resolves
        let snap = try await db.collection("users").document(uid)
            .collection("responses")
            .order(by: "createdAt", descending: true)
            .getDocuments()

        return snap.documents.map { doc in
            let data = doc.data()
            let score = data["scorePercent"] as? Int ?? 0
            let safety = data["flaggedSafety"] as? Bool ?? false

            var created: Date? = nil
            if let ts = data["createdAt"] as? Timestamp {
                created = ts.dateValue()
            }
            return HistoryItem(id: doc.documentID, scorePercent: score, flaggedSafety: safety, createdAt: created)
        }
    }
}
#endif
