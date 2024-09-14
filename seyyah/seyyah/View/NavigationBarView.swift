//
//  NavigationBarView.swift
//  seyyah
//
//  Created by semihkesgin on 5.09.2024.
//
import SwiftUI

struct NavigationBarView: View {
    @State private var selectedIndex: Int = 0

    var body: some View {
        

        TabView(selection: $selectedIndex) {
            NavigationStack() {
                HomeView()
            }
            .tabItem {
                Text("Home")
                Image(systemName: "house.fill")
                    .renderingMode(.template)
            }
            .tag(0)
            
            NavigationStack() {
             //  PassportView()
            }
            .tabItem {
                Label("Passport", systemImage: "book.pages.fill")
            }
            .tag(1)
            
            NavigationStack() {
                SettingsView()
                
            }
            .tabItem {
                Text("Settings")
                Image(systemName: "gear")
            }
            .tag(2)
        }
        //1
        .tint(.blue)
        
    }
}

#Preview {
    NavigationBarView()
}
