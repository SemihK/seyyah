//
//  NotificationExplanationView.swift
//  seyyah
//
//  Created by semihkesgin on 15.09.2024.
//

import SwiftUI

struct NotificationExplanationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30) {
            Image("Logo-Text")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150)
            
            
            Image(systemName: "bell.badge.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Bildirimlere İzin Verin")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Bildirimlerin bazen can sıkıcı olduğunu kabul ediyoruz, fakat uygulamamızın tam olarak çalışması için bildirimlere ihtiyacımız var. Bildirimler sayesinde size önemli güncellemeler, seyahat bildirimleri ve özel rozetler sunabiliriz.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                openAppSettings()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Bildirimlere İzin Ver")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Daha Sonra")
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .padding()
    }
    
    private func openAppSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}

struct NotificationExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationExplanationView()
    }
}
