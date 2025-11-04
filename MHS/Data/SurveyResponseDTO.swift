//
//  SurveyResponseDTO.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

import Foundation

struct SurveyResponseDTO {
    let scorePercent: Int
    let flaggedSafety: Bool
    let answers: [String: String]   // questionID -> optionID
    let surveyVersion: Int          // bump when you change questions/weights
}

extension SurveyResponseDTO {
    func toFirestoreData() -> [String: Any] {
        return [
            "scorePercent": scorePercent,
            "flaggedSafety": flaggedSafety,
            "answers": answers,
            "surveyVersion": surveyVersion,
            // createdAt is set server-side for consistency
        ]
    }
}
