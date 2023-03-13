//
//  AppState.swift
//  Jena Store
//
//

import Combine

final class AppState: ObservableObject {
    @Published var appFlowState: AppFlowState = .start

    static let shared = AppState()

    private init() { }
}

extension AppState {
    enum AppFlowState {
        case start
    }
}
