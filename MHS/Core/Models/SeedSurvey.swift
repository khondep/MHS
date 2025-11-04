//
//  SeedSurvey.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

import Foundation

enum SeedSurvey {
    static let questions: [SurveyQuestion] = [
        // 1) Sleep
        .init(
            id: "q_sleep",
            text: "How many hours of sleep do you usually get each night?",
            questionRank: 3,
            options: [
                .init(id: "o_sleep_7to9", text: "7–9 hours", optionWeight: 1.0),
                .init(id: "o_sleep_6to7", text: "6–7 hours", optionWeight: 0.8),
                .init(id: "o_sleep_5to6", text: "5–6 hours", optionWeight: 0.5),
                .init(id: "o_sleep_u5",   text: "Under 5 hours", optionWeight: 0.2),
            ],
            isSafetyItem: false
        ),
        // 2) Mood
        .init(
            id: "q_mood",
            text: "In the past 2 weeks, how often have you felt down or hopeless?",
            questionRank: 3,
            options: [
                .init(id: "o_mood_none",  text: "Not at all", optionWeight: 1.0),
                .init(id: "o_mood_some",  text: "Several days", optionWeight: 0.6),
                .init(id: "o_mood_more",  text: "More than half the days", optionWeight: 0.3),
                .init(id: "o_mood_daily", text: "Nearly every day", optionWeight: 0.1),
            ],
            isSafetyItem: false
        ),
        // 3) Anxiety
        .init(
            id: "q_anx",
            text: "In the past 2 weeks, how often have you felt nervous or anxious?",
            questionRank: 2,
            options: [
                .init(id: "o_anx_none", text: "Not at all", optionWeight: 1.0),
                .init(id: "o_anx_some", text: "Several days", optionWeight: 0.7),
                .init(id: "o_anx_more", text: "More than half the days", optionWeight: 0.4),
                .init(id: "o_anx_daily", text: "Nearly every day", optionWeight: 0.2),
            ],
            isSafetyItem: false
        ),
        // 4) Energy
        .init(
            id: "q_energy",
            text: "How would you rate your energy levels lately?",
            questionRank: 2,
            options: [
                .init(id: "o_en_high", text: "High and steady", optionWeight: 1.0),
                .init(id: "o_en_ok",   text: "Mostly okay", optionWeight: 0.7),
                .init(id: "o_en_low",  text: "Often low", optionWeight: 0.4),
                .init(id: "o_en_vlow", text: "Very low most days", optionWeight: 0.2),
            ],
            isSafetyItem: false
        ),
        // 5) Social
        .init(
            id: "q_social",
            text: "How connected do you feel to friends or family?",
            questionRank: 1,
            options: [
                .init(id: "o_soc_high", text: "Very connected", optionWeight: 1.0),
                .init(id: "o_soc_some", text: "Somewhat connected", optionWeight: 0.7),
                .init(id: "o_soc_rare", text: "Rarely connected", optionWeight: 0.4),
                .init(id: "o_soc_iso",  text: "I feel isolated", optionWeight: 0.2),
            ],
            isSafetyItem: false
        ),
        // 6) Activity
        .init(
            id: "q_activity",
            text: "How often are you physically active (≥ 20–30 min)?",
            questionRank: 1,
            options: [
                .init(id: "o_act_5", text: "5–7 days/week", optionWeight: 1.0),
                .init(id: "o_act_3", text: "3–4 days/week", optionWeight: 0.8),
                .init(id: "o_act_1", text: "1–2 days/week", optionWeight: 0.5),
                .init(id: "o_act_0", text: "Rarely or never", optionWeight: 0.2),
            ],
            isSafetyItem: false
        ),
        // 7) Safety (self-harm screener)
        .init(
            id: "q_safety",
            text: "In the past 2 weeks, have you had thoughts of harming yourself?",
            questionRank: 3,
            options: [
                .init(id: "o_safe_no",    text: "No", optionWeight: 1.0),
                .init(id: "o_safe_once",  text: "Yes, once or twice", optionWeight: 0.2),
                .init(id: "o_safe_often", text: "Yes, more often", optionWeight: 0.1),
            ],
            isSafetyItem: true
        )
    ]
}
