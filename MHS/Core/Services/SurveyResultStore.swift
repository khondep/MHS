//
//  SurveyResultStore.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

import Foundation

protocol SurveyResultStore {
    func saveResponse(_ dto: SurveyResponseDTO) async throws
}

final class FirestoreSurveyResultStore: SurveyResultStore {
    func saveResponse(_ dto: SurveyResponseDTO) async throws {
        #if canImport(FirebaseFirestore)
        try await saveToFirestore(dto)
        #else
        // Fallback: do nothing so the app still runs without Firestore present
        #endif
    }
}

#if canImport(FirebaseFirestore)
import FirebaseAuth
import FirebaseFirestore

private extension FirestoreSurveyResultStore {
    func saveToFirestore(_ dto: SurveyResponseDTO) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "SurveyResultStore", code: 401, userInfo: [NSLocalizedDescriptionKey: "No authenticated user"])
        }

        let db = Firestore.firestore()
        var data = dto.toFirestoreData()
        data["createdAt"] = FieldValue.serverTimestamp()

        try await db
            .collection("users").document(uid)
            .collection("responses").addDocument(data: data)
    }
}
#endif
