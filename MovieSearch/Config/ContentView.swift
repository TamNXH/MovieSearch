//
//  ContentView.swift
//
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            contentView
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - Private method
private extension ContentView {
    @ViewBuilder var contentView: some View {
        switch appState.appFlowState {
        case .start:
            homeView
        }
    }

    var homeView: some View {
        HomeView()
    }
}
