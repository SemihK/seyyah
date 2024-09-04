//
//  ContentView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingCompleted") private var onboardingCompleted: Bool = false

    var body: some View {
        if onboardingCompleted {
            HomeView()
        } else {
            OnboardingView()
        }
    }
}
#Preview {
    ContentView()
    
}
