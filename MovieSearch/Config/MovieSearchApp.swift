//
//  MovieSearchApp.swift
//
//

import SwiftUI

@main
struct MovieSearchApp: App {
    @Environment(\.scenePhase) private var scenePhase

    // App state environment variable
    let appState = AppState.shared

    init() {
        Logger.debug("Application Init")
    }

    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                Logger.debug("App open URL \(url)")
            }
            .environmentObject(appState)
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                Logger.info("App Background State")
            case .inactive:
                Logger.info("App Inactive State")
            case .active:
                Logger.info("App Active State")
            @unknown default:
                Logger.info("Unknow App State")
            }
        }
    }
}
