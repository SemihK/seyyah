//
//  HomeView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//

import SwiftUI

struct HomeView: View {
    var userName: String {
        UserDefaults.standard.string(forKey: "userName") ?? "User"
    }

    var body: some View {
        VStack {
            ZStack {
                Text("Welcome \(userName)")
                    .font(.largeTitle)
                    .padding()
                Rectangle()
                    .foregroundStyle(.accent)
                    .frame(width: 350, height: 100)
                    .padding(.top, -350)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
    
#Preview {
    HomeView()
}
