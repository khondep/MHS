//
//  ResultsView.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

//
//import SwiftUI
//
//struct ResultsView: View {
//    let router: AppRouter
//    let result: ScoreResult
//
//    // MARK: - Derived state
//    private var isHealthy: Bool { result.percent >= ScoreEngine.healthyThreshold }
//    private var needsHelp: Bool { result.flaggedSafety || !isHealthy }
//
//    private var statusText: String {
//        if result.flaggedSafety { return "⚠️ Safety flagged — please seek immediate support." }
//        return isHealthy ? "👍 Your mental health score looks good." : "👋 Your score is below our wellness threshold."
//    }
//
//    @State private var showHelpSheet = false   // ✅ new
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                Text("Your Mental Health Score")
//                    .font(.title2).bold()
//
//                ScoreRing(percent: result.percent, threshold: ScoreEngine.healthyThreshold)
//                    .frame(width: 160, height: 160)
//                    .padding(.top, 4)
//                    .accessibilityLabel("Mental Health Score \(result.percent) percent")
//
//                VStack(spacing: 8) {
//                    Text("\(result.percent)%")
//                        .font(.system(size: 44, weight: .heavy, design: .rounded))
//                    Text(statusText)
//                        .multilineTextAlignment(.center)
//                        .foregroundStyle(.secondary)
//                    Text("Threshold: \(ScoreEngine.healthyThreshold)%")
//                        .font(.footnote)
//                        .foregroundStyle(.secondary)
//                }
//
//                if result.flaggedSafety {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Label("If you’re in immediate danger, call your local emergency number.", systemImage: "exclamationmark.triangle.fill")
//                            .foregroundStyle(.orange)
//                            .font(.subheadline.bold())
//                        Text("You can also contact local crisis services or a trusted person right now.")
//                            .font(.footnote)
//                            .foregroundStyle(.secondary)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding()
//                    .background(.orange.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
//                }
//
//                // Actions
//                VStack(spacing: 12) {
//                    if needsHelp {
//                        Button {
//                            router.push(.specialists)
//                        } label: {
//                            Text("See Specialists")
//                                .frame(maxWidth: .infinity)
//                        }
//                        .buttonStyle(.borderedProminent)
//
//                        if result.flaggedSafety {
//                            Button {
//                                showHelpSheet = true              // ✅ show help sheet
//                            } label: {
//                                Label("Get Help Now", systemImage: "lifepreserver")
//                                    .frame(maxWidth: .infinity)
//                            }
//                            .buttonStyle(.bordered)
//                        }
//                    } else {
//                        Button {
//                            router.popToRoot()
//                        } label: {
//                            Text("Done")
//                                .frame(maxWidth: .infinity)
//                        }
//                        .buttonStyle(.bordered)
//                    }
//
//                    Button {
//                        router.push(.history)
//                    } label: {
//                        Label("View History", systemImage: "clock.arrow.circlepath")
//                            .frame(maxWidth: .infinity)
//                    }
//                    .buttonStyle(.bordered)
//                }
//                .padding(.top, 4)
//            }
//            .padding()
//        }
//        .navigationTitle("Results")
//        .sheet(isPresented: $showHelpSheet) {   // ✅ sheet
//            HelpNowView()
//        }
//    }
//}
//
//// MARK: - Score Ring
//
//private struct ScoreRing: View {
//    let percent: Int
//    let threshold: Int
//    @State private var animated: CGFloat = 0
//
//    private var progress: CGFloat { max(0, min(1, CGFloat(percent) / 100.0)) }
//    private var thresholdProgress: CGFloat { max(0, min(1, CGFloat(threshold) / 100.0)) }
//
//    var body: some View {
//        ZStack {
//            Circle().stroke(lineWidth: 14).foregroundStyle(.gray.opacity(0.15))
//            Circle()
//                .trim(from: 0, to: thresholdProgress)
//                .stroke(style: StrokeStyle(lineWidth: 14, lineCap: .round))
//                .foregroundStyle(.gray.opacity(0.25))
//                .rotationEffect(.degrees(-90))
//            Circle()
//                .trim(from: 0, to: animated)
//                .stroke(
//                    AngularGradient(
//                        gradient: Gradient(colors: [.green, .yellow, .orange, .red]),
//                        center: .center,
//                        startAngle: .degrees(-90),
//                        endAngle: .degrees(270)
//                    ),
//                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
//                )
//                .rotationEffect(.degrees(-90))
//                .animation(.easeOut(duration: 0.9), value: animated)
//            VStack(spacing: 2) {
//                Text("MHS").font(.caption).foregroundStyle(.secondary)
//                Text("\(percent)%").font(.title2).bold()
//            }
//        }
//        .onAppear { animated = progress }
//        .accessibilityElement(children: .ignore)
//        .accessibilityLabel("Score ring")
//        .accessibilityValue("\(percent) percent")
//    }
//}





import SwiftUI

struct ResultsView: View {
    let router: AppRouter
    let result: ScoreResult

    // MARK: - Derived state
    private var isHealthy: Bool { result.percent >= ScoreEngine.healthyThreshold }
    private var needsHelp: Bool { result.flaggedSafety || !isHealthy }

    private var statusText: String {
        if result.flaggedSafety { return "⚠️ Safety flagged — please seek immediate support." }
        return isHealthy ? "👍 Your mental health score looks good." : "👋 Your score is below our wellness threshold."
    }

    @State private var showHelpSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Your Mental Health Score")
                    .font(.title2).bold()
                    .accessibilityAddTraits(.isHeader)

                ScoreRing(percent: result.percent, threshold: ScoreEngine.healthyThreshold)
                    .frame(width: 160, height: 160)
                    .padding(.top, 4)
                    .accessibilityLabel("Mental Health Score \(result.percent) percent")

                VStack(spacing: 8) {
                    Text("\(result.percent)%")
                        .font(.system(size: 44, weight: .heavy, design: .rounded))
                        .accessibilityHidden(true)

                    Text(statusText)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .accessibilityLabel(statusText)

                    Text("Threshold: \(ScoreEngine.healthyThreshold)%")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                }

                if result.flaggedSafety {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("If you’re in immediate danger, call your local emergency number.", systemImage: "exclamationmark.triangle.fill")
                            .foregroundStyle(.orange)
                            .font(.subheadline.bold())
                        Text("You can also contact local crisis services or a trusted person right now.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.orange.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                    .accessibilityElement(children: .combine)
                }

                // Actions
                VStack(spacing: 12) {
                    if needsHelp {
                        Button {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            router.push(.specialists)
                        } label: {
                            Text("See Specialists")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)

                        if result.flaggedSafety {
                            Button {
                                showHelpSheet = true
                            } label: {
                                Label("Get Help Now", systemImage: "lifepreserver")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                        }

                        Button {
                            retakeSurvey()
                        } label: {
                            Label("Retake Survey", systemImage: "arrow.clockwise")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    } else {
                        Button {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            router.popToRoot()
                        } label: {
                            Text("Done")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)

                        Button {
                            retakeSurvey()
                        } label: {
                            Label("Retake Survey", systemImage: "arrow.clockwise")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }

                    Button {
                        router.push(.history)
                    } label: {
                        Label("View History", systemImage: "clock.arrow.circlepath")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top, 4)
            }
            .padding()
        }
        .navigationTitle("Results")
        .sheet(isPresented: $showHelpSheet) {
            HelpNowView()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.push(.settings)
                } label: {
                    Image(systemName: "gearshape")
                }
                .accessibilityLabel("Settings")
            }
        }
    }

    private func retakeSurvey() {
        // Simple reset: go back to root then push Survey
        router.popToRoot()
        router.push(.survey)
    }
}

// MARK: - Score Ring

private struct ScoreRing: View {
    let percent: Int
    let threshold: Int
    @State private var animated: CGFloat = 0

    private var progress: CGFloat { max(0, min(1, CGFloat(percent) / 100.0)) }
    private var thresholdProgress: CGFloat { max(0, min(1, CGFloat(threshold) / 100.0)) }

    var body: some View {
        ZStack {
            Circle().stroke(lineWidth: 14).foregroundStyle(.gray.opacity(0.15))

            // Threshold marker
            Circle()
                .trim(from: 0, to: thresholdProgress)
                .stroke(style: StrokeStyle(lineWidth: 14, lineCap: .round))
                .foregroundStyle(.gray.opacity(0.25))
                .rotationEffect(.degrees(-90))

            // Progress arc (animated)
            Circle()
                .trim(from: 0, to: animated)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.green, .yellow, .orange, .red]),
                        center: .center,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(270)
                    ),
                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.9), value: animated)

            // Center text
            VStack(spacing: 2) {
                Text("MHS").font(.caption).foregroundStyle(.secondary)
                Text("\(percent)%").font(.title2).bold()
            }
        }
        .onAppear { animated = progress }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Score ring")
        .accessibilityValue("\(percent) percent")
    }
}
