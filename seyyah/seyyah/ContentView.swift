//
//  ContentView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//


import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingCompleted") private var isOnboardingCompleted: Bool = false
    
    var body: some View {
        if isOnboardingCompleted {
            HomeView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
#Preview {
    ContentView()
}
