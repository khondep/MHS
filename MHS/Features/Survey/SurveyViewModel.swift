//
//  SurveyViewModel.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

import Foundation
import Combine

final class SurveyViewModel: ObservableObject {
    @Published var questions: [SurveyQuestion] = []
    @Published var answers: [String: String] = [:]   // qID -> optionID

    private let surveyService: SurveyServiceProtocol

    init(surveyService: SurveyServiceProtocol = SurveyService()) {
        self.surveyService = surveyService
        self.questions = surveyService.loadQuestions()
    }

    func select(option optionID: String, for questionID: String) {
        answers[questionID] = optionID
    }

    var isComplete: Bool {
        !questions.isEmpty && answers.count == questions.count
    }
}
