//
//  ContentView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//


import SwiftUI

struct ContentView: View {
    @State private var showOnboarding: Bool

    init() {
        // Bayrağı kontrol et ve uygun ekranı göster
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        self._showOnboarding = State(initialValue: !hasCompletedOnboarding)
    }
    
    var body: some View {
        NavigationView {
            if showOnboarding {
                OnboardingView()
                    .transition(.opacity)
            } else {
                HomeView()
            }
        }
    }
}
#Preview {
    ContentView()
}
