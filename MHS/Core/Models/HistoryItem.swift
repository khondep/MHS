//
//  HistoryService.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//
import Foundation

struct HistoryItem: Identifiable, Hashable {
    let id: String
    let scorePercent: Int
    let flaggedSafety: Bool
    let createdAt: Date?
}
