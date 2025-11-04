
//
//  SurveyService.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

import Foundation

protocol SurveyServiceProtocol {
    func loadQuestions() -> [SurveyQuestion]
}

final class SurveyService: SurveyServiceProtocol {
    func loadQuestions() -> [SurveyQuestion] { SeedSurvey.questions }
}
