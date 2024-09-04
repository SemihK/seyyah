//
//  ContentView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if UserDefaults.standard.bool(forKey: "onboardingCompleted") {
            HomeView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
    
}
