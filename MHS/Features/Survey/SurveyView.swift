//
//  SurveyView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//
//import SwiftUI
//
//struct SurveyView: View {
//    let router: AppRouter
//    @StateObject private var vm = SurveyViewModel()
//
//    var body: some View {
//        VStack {
//            List {
//                ForEach(vm.questions) { q in
//                    Section(q.text) {
//                        ForEach(q.options) { opt in
//                            HStack {
//                                Image(systemName: vm.answers[q.id] == opt.id ? "largecircle.fill.circle" : "circle")
//                                Text(opt.text)
//                                Spacer()
//                            }
//                            .contentShape(Rectangle())
//                            .onTapGesture { vm.select(option: opt.id, for: q.id) }
//                        }
//                    }
//                }
//            }
//
//            Button {
//                submit()
//            } label: {
//                Text(vm.isComplete ? "Submit" : "Answer all questions")
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(.borderedProminent)
//            .padding()
//            .disabled(!vm.isComplete)
//        }
//        .navigationTitle("Survey")
//    }
//
//    private func submit() {
//        let score = ScoreEngine.computeScore(from: vm.answers, questions: vm.questions)
//        router.push(.results(score))   // ✅ navigate to Results screen
//    }
//}


import SwiftUI

struct SurveyView: View {
    let router: AppRouter
    @StateObject private var vm = SurveyViewModel()

    // add a store instance
    private let resultStore: SurveyResultStore = FirestoreSurveyResultStore()

    var body: some View {
        VStack {
            List {
                ForEach(vm.questions) { q in
                    Section(q.text) {
                        ForEach(q.options) { opt in
                            HStack {
                                Image(systemName: vm.answers[q.id] == opt.id ? "largecircle.fill.circle" : "circle")
                                Text(opt.text)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture { vm.select(option: opt.id, for: q.id) }
                        }
                    }
                }
            }

            Button {
                submit()
            } label: {
                Text(vm.isComplete ? "Submit" : "Answer all questions")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .disabled(!vm.isComplete)
        }
        .navigationTitle("Survey")
    }

    private func submit() {
        let score = ScoreEngine.computeScore(from: vm.answers, questions: vm.questions)

        // Fire-and-forget save (don’t block UI); log errors if any
        Task {
            let dto = SurveyResponseDTO(
                scorePercent: score.percent,
                flaggedSafety: score.flaggedSafety,
                answers: vm.answers,
                surveyVersion: 1
            )
            do { try await resultStore.saveResponse(dto) }
            catch { print("Failed to save response: \(error.localizedDescription)") }
        }

        router.push(.results(score))
    }
}
