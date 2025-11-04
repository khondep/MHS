//
//  AppRouter.swift
//  MHS
//
//  Created by Purvang Khonde on 11/3/25.
//

import Foundation
import Combine   // ✅ needed for ObservableObject and @Published

enum AppRoute: Hashable {
    case auth
    case survey
    case results(ScoreResult)   
    case specialists
    case history
    case settings          
}
final class AppRouter: ObservableObject {
    @Published var path: [AppRoute] = []

    func push(_ route: AppRoute) { path.append(route) }
    func popToRoot() { path.removeAll() }
}
