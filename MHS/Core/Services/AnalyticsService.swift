//
//  AnalyticsService.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

// Core/Services/AnalyticsService.swift
import Foundation
#if canImport(FirebaseAnalytics)
import FirebaseAnalytics
#endif

enum AnalyticsService {
    static func log(_ name: String, params: [String: Any]? = nil) {
        #if canImport(FirebaseAnalytics)
        Analytics.logEvent(name, parameters: params)
        #endif
        // (Optional) print(params) for debug builds
    }
}
