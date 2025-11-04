//
//  Models.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

import Foundation

// Option presented for a question
struct SurveyOption: Identifiable, Codable, Hashable {
    let id: String
    let text: String
    let optionWeight: Double   // 0.0 (least healthy) ... 1.0 (most healthy)
}

// A survey question with a relative importance (rank)
struct SurveyQuestion: Identifiable, Codable, Hashable {
    let id: String
    let text: String
    let questionRank: Int      // 1 (low) ... 3 (high)
    let options: [SurveyOption]
    let isSafetyItem: Bool     // self-harm screener? (true/false)
}

// Specialist directory item (we'll fetch from backend later)
struct Specialist: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let specialty: String
    let location: String
    let acceptsTelehealth: Bool
    let bookingURL: URL?
}

// Computed result
struct ScoreResult: Hashable, Codable {
    let percent: Int
    let flaggedSafety: Bool
}

enum ScoreEngine {
    static let healthyThreshold = 70  // ≥ 70% = “good”, < 70% → suggest specialist

    /// answers: [questionID: optionID]
    static func computeScore(from answers: [String: String], questions: [SurveyQuestion]) -> ScoreResult {
        var raw: Double = 0
        var maxPossible: Double = 0
        var safetyFlag = false

        for q in questions {
            maxPossible += Double(q.questionRank) * 1.0
            if let optionID = answers[q.id],
               let selected = q.options.first(where: { $0.id == optionID }) {
                raw += Double(q.questionRank) * selected.optionWeight
                if q.isSafetyItem, selected.optionWeight < 0.5 { safetyFlag = true }
            }
        }

        let percent = maxPossible > 0 ? Int((raw / maxPossible) * 100.0 + 0.5) : 0
        return ScoreResult(percent: min(max(percent, 0), 100), flaggedSafety: safetyFlag)
    }
}
