//
//  SpecialistService.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//
//
//import Foundation
//
//protocol SpecialistServiceProtocol {
//    func listSpecialists() async -> [Specialist]
//}
//
//final class SpecialistService: SpecialistServiceProtocol {
//    func listSpecialists() async -> [Specialist] {
//        // Stubbed; later we’ll fetch from Firestore
//        return [
//            .init(id: "s1", name: "Dr. Maya Patel", specialty: "Clinical Psychologist",
//                  location: "New York, NY • Telehealth", acceptsTelehealth: true,
//                  bookingURL: URL(string: "https://example.com/maya")),
//            .init(id: "s2", name: "Jordan Kim, LCSW", specialty: "Therapist",
//                  location: "Remote • Telehealth", acceptsTelehealth: true,
//                  bookingURL: URL(string: "https://example.com/jordan"))
//        ]
//    }
//}
import Foundation

protocol SpecialistServiceProtocol {
    func listSpecialists() async throws -> [Specialist]
}

final class SpecialistService: SpecialistServiceProtocol {
    func listSpecialists() async throws -> [Specialist] {
        #if canImport(FirebaseFirestore)
        return try await fetchFromFirestore()
        #else
        // Fallback so the app still builds without Firebase packages
        return [
            .init(id: "stub1", name: "Dr. Maya Patel", specialty: "Clinical Psychologist",
                  location: "New York, NY • Telehealth", acceptsTelehealth: true,
                  bookingURL: URL(string: "https://example.com/maya")),
            .init(id: "stub2", name: "Jordan Kim, LCSW", specialty: "Therapist",
                  location: "Remote • Telehealth", acceptsTelehealth: true,
                  bookingURL: URL(string: "https://example.com/jordan"))
        ]
        #endif
    }
}

#if canImport(FirebaseFirestore)
import FirebaseFirestore

private extension SpecialistService {
    func fetchFromFirestore() async throws -> [Specialist] {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("specialists").getDocuments()

        return snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard
                let name = data["name"] as? String,
                let specialty = data["specialty"] as? String,
                let location = data["location"] as? String,
                let acceptsTelehealth = data["acceptsTelehealth"] as? Bool
            else {
                return nil // skip malformed docs
            }

            let bookingURLString = data["bookingURL"] as? String
            let url = bookingURLString.flatMap { URL(string: $0) }

            return Specialist(
                id: doc.documentID,
                name: name,
                specialty: specialty,
                location: location,
                acceptsTelehealth: acceptsTelehealth,
                bookingURL: url
            )
        }
    }
}
#endif
