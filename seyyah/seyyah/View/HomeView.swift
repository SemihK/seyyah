//
//  HomeView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//

import SwiftUI

struct HomeView: View {
<<<<<<< Updated upstream
    var body: some View {
        VStack {
            // HomeView içeriği
            Text("Welcome to HomeView")
        }
        .navigationBarBackButtonHidden(true) // Back butonunu gizle
=======
    var userName: String {
        UserDefaults.standard.string(forKey: "userName") ?? "Traveller"
    }

    var body: some View {
        VStack {
            
            ZStack {
                Color.accentColor
                                .ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(width: 320, height: 90)
                        .foregroundColor(.gray.opacity(0.1))
                    Text("Good Day \(userName)") // MARK zaman bazlı karşılama mesajı eklenecek.
                        .font(.largeTitle)
                        .padding()
                        .foregroundStyle(LinearGradient(
                            colors: [.red, .purple, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                }
                .padding(.top, -350)
                // MARK harita görünümü gelecek kullanıcının nerede olduğunu göstereceğiz.
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(width: 320, height: 200)
                    .foregroundColor(.gray.opacity(0.1))
                    .padding(.top, -230)
                // MARK 
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(width: 320, height: 200)
                    .foregroundColor(.gray.opacity(0.1))
                    .padding(.top, 200)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
>>>>>>> Stashed changes
    }
    
}
#Preview {
    HomeView()
}
