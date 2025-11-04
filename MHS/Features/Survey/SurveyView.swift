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

//
//import SwiftUI
//
//struct SurveyView: View {
//    let router: AppRouter
//    @StateObject private var vm = SurveyViewModel()
//
//    // add a store instance
//    private let resultStore: SurveyResultStore = FirestoreSurveyResultStore()
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
//
//        // Fire-and-forget save (don’t block UI); log errors if any
//        Task {
//            let dto = SurveyResponseDTO(
//                scorePercent: score.percent,
//                flaggedSafety: score.flaggedSafety,
//                answers: vm.answers,
//                surveyVersion: 1
//            )
//            do { try await resultStore.saveResponse(dto) }
//            catch { print("Failed to save response: \(error.localizedDescription)") }
//        }
//
//        router.push(.results(score))
//    }
//}


import SwiftUI

struct SurveyView: View {
    let router: AppRouter
    @StateObject private var vm = SurveyViewModel()

    // Save results
    private let resultStore: SurveyResultStore = FirestoreSurveyResultStore()

    // Tip card shown on first visit only
    @AppStorage("survey.showTip") private var showTip = true

    var body: some View {
        VStack(spacing: 0) {

            // Top progress
            VStack(spacing: 6) {
                ProgressView(value: Double(vm.answeredCount), total: Double(vm.questions.count))
                Text("Answered \(vm.answeredCount) of \(vm.questions.count)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.top, 8)

            // Tip (dismissable)
            if showTip {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "lightbulb.fill")
                        .imageScale(.large)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("How this works").font(.subheadline).bold()
                        Text("Your score is a weighted average across sleep, mood, energy and more. If safety is flagged or your score falls below the threshold, we’ll suggest specialists.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button {
                        showTip = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .buttonStyle(.plain)
                }
                .padding(12)
                .background(.gray.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .padding(.vertical, 8)
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            // Questions
            List {
                ForEach(vm.questions) { q in
                    Section(q.text) {
                        ForEach(q.options) { opt in
                            HStack {
                                Image(systemName: vm.answers[q.id] == opt.id ? "largecircle.fill.circle" : "circle")
                                    .symbolEffect(.bounce, options: .speed(2), value: vm.answers[q.id] == opt.id)
                                Text(opt.text)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                                    vm.select(option: opt.id, for: q.id)
                                }
                            }
                        }
                    }
                }
            }

            // Submit
            Button(action: submit) {
                Text(vm.isComplete ? "Submit" : "Answer all questions")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .disabled(!vm.isComplete)
        }
        .navigationTitle("Survey")
        .onAppear {
            // Optional analytics hook (safe to remove if not using)
            AnalyticsService.log("survey_started")
        }
    }

    private func submit() {
        let score = ScoreEngine.computeScore(from: vm.answers, questions: vm.questions)

        // Optional analytics hook
        AnalyticsService.log("survey_submitted", params: [
            "percent": score.percent,
            "safety": score.flaggedSafety
        ])

        // Haptic
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()

        // Fire-and-forget save
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
