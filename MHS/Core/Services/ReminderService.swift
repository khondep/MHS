//
//  ReminderService.swift
//  MHS
//
//  Created by Purvang Khonde on 11/4/25.
//

//// Core/Services/ReminderService.swift
//import Foundation
//import UserNotifications
//
//enum ReminderService {
//    static func requestPermission() async -> Bool {
//        let center = UNUserNotificationCenter.current()
//        return (try? await center.requestAuthorization(options: [.alert, .sound, .badge])) ?? false
//    }
//
//    static func scheduleWeekly(weekday: Int = 2, hour: Int = 9, minute: Int = 0) async throws {
//        // weekday: 1=Sun, 2=Mon, ...
//        let center = UNUserNotificationCenter.current()
//        try await center.removePendingNotificationRequests(withIdentifiers: ["weekly_mhs"])
//        var date = DateComponents()
//        date.weekday = weekday; date.hour = hour; date.minute = minute
//        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
//        let content = UNMutableNotificationContent()
//        content.title = "Time for a quick check-in"
//        content.body = "Take 2 minutes to update your Mental Health Score."
//        let req = UNNotificationRequest(identifier: "weekly_mhs", content: content, trigger: trigger)
//        try await center.add(req)
//    }
//
//    static func cancelWeekly() async {
//        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["weekly_mhs"])
//    }
//}


import Foundation
import UserNotifications

enum ReminderService {
    /// Ask the user for notification permission.
    static func requestPermission() async -> Bool {
        let center = UNUserNotificationCenter.current()
        do {
            return try await center.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            return false
        }
    }

    /// Schedule a weekly reminder (default: Monday 9:00 AM).
    /// weekday: 1 = Sunday, 2 = Monday, ... 7 = Saturday
    static func scheduleWeekly(weekday: Int = 2, hour: Int = 9, minute: Int = 0) async throws {
        let center = UNUserNotificationCenter.current()

        // 🔧 This call is synchronous and non-throwing — no try/await
        center.removePendingNotificationRequests(withIdentifiers: ["weekly_mhs"])

        var date = DateComponents()
        date.weekday = weekday
        date.hour = hour
        date.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

        let content = UNMutableNotificationContent()
        content.title = "Time for a quick check-in"
        content.body = "Take 2 minutes to update your Mental Health Score."

        let request = UNNotificationRequest(identifier: "weekly_mhs", content: content, trigger: trigger)

        // `add` is async/throws on iOS 16+, so `try await` is correct here
        try await center.add(request)
    }

    /// Cancel the weekly reminder.
    static func cancelWeekly() async {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["weekly_mhs"])
    }
}
