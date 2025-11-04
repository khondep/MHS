//
//  DTOs.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//
//
//import Foundation
//import FirebaseFirestoreSwift
//
//struct SpecialistDTO: Codable {
//    @DocumentID var id: String?
//    let name: String
//    let specialty: String
//    let location: String
//    let acceptsTelehealth: Bool
//    let bookingURL: String?
//}
//
//extension SpecialistDTO {
//    func toDomain() -> Specialist? {
//        guard let id = id else { return nil }
//        return Specialist(
//            id: id,
//            name: name,
//            specialty: specialty,
//            location: location,
//            acceptsTelehealth: acceptsTelehealth,
//            bookingURL: bookingURL.flatMap(URL.init(string:))
//        )
//    }
//}


import Foundation

// DTO (Data Transfer Object) version of Specialist for Firestore raw parsing
struct SpecialistDTO {
    let id: String
    let name: String
    let specialty: String
    let location: String
    let acceptsTelehealth: Bool
    let bookingURL: String?
}

// Convert from Firestore document data dictionary to DTO
extension SpecialistDTO {
    static func fromFirestore(id: String, data: [String: Any]) -> SpecialistDTO? {
        guard
            let name = data["name"] as? String,
            let specialty = data["specialty"] as? String,
            let location = data["location"] as? String,
            let acceptsTelehealth = data["acceptsTelehealth"] as? Bool
        else {
            return nil
        }

        let bookingURL = data["bookingURL"] as? String
        return SpecialistDTO(
            id: id,
            name: name,
            specialty: specialty,
            location: location,
            acceptsTelehealth: acceptsTelehealth,
            bookingURL: bookingURL
        )
    }

    func toDomain() -> Specialist {
        Specialist(
            id: id,
            name: name,
            specialty: specialty,
            location: location,
            acceptsTelehealth: acceptsTelehealth,
            bookingURL: bookingURL.flatMap(URL.init(string:))
        )
    }
}
