//
//  SettingsView.swift
//  seyyah
//
//  Created by semihkesgin on 5.09.2024.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    // MARK: - Properties
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userEmail") private var userEmail: String = ""
    @AppStorage("appleUserID") private var appleUserID: String = ""
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @State private var isNotificationsEnabled: Bool = false
    @State private var showingLogoutAlert = false
    @State private var showingNotificationAlert = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                profileSection
                settingsSection
                logoutSection
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Ayarlar")
        }
        .alert("Çıkış Yap", isPresented: $showingLogoutAlert) {
            Button("İptal", role: .cancel) { }
            Button("Çıkış Yap", role: .destructive, action: logout)
        } message: {
            Text("Çıkış yapmak istediğinizden emin misiniz?")
        }
        .alert("Bildirim İzni", isPresented: $showingNotificationAlert) {
            Button("İptal", role: .cancel) { }
            Button("Ayarları Aç", action: openAppSettings)
        } message: {
            Text("Bildirimleri etkinleştirmek için uygulama ayarlarını açmak ister misiniz?")
        }
        .onAppear(perform: setup)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    // MARK: - View Components
    private var profileSection: some View {
        Section {
            HStack(spacing: 15) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                VStack(alignment: .leading, spacing: 5) {
                    Text(userName)
                        .font(.headline)
                    Text(userEmail)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 10)
        }
    }
    
    private var settingsSection: some View {
        Section(header: Text("Uygulama Ayarları")) {
            Toggle("Karanlık Mod", isOn: $isDarkMode)
                .onChange(of: isDarkMode, perform: updateAppearance)
            Toggle("Bildirimler", isOn: $isNotificationsEnabled)
                .onChange(of: isNotificationsEnabled, perform: handleNotificationToggle)
        }
    }
    
    private var logoutSection: some View {
        Section {
            Button(action: { showingLogoutAlert = true }) {
                Text("Çıkış Yap")
                    .foregroundColor(.red)
            }
        }
    }
    
    // MARK: - Methods
    private func setup() {
        loadUserData()
        checkNotificationStatus()
    }
    
    private func loadUserData() {
        if !appleUserID.isEmpty {
            // Apple API çağrısı yapılacak
        }
    }
    
    private func logout() {
        userName = ""
        userEmail = ""
        appleUserID = ""
        // Diğer kullanıcı verilerini temizle
        // Kullanıcıyı giriş ekranına yönlendir
    }
    
    private func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isNotificationsEnabled = settings.authorizationStatus == .authorized
            }
        }
    }
    
    private func updateAppearance(_ isDark: Bool) {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDark ? .dark : .light
    }
    
    private func handleNotificationToggle(_ isEnabled: Bool) {
        if isEnabled {
            requestNotificationPermission()
        } else {
            isNotificationsEnabled = true // Toggle'ı geri aç
            showingNotificationAlert = true
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined:
                    self.askForNotificationPermission()
                case .denied:
                    self.showingNotificationAlert = true
                case .authorized, .provisional, .ephemeral:
                    self.isNotificationsEnabled = true
                @unknown default:
                    break
                }
            }
        }
    }
    
    private func askForNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                self.isNotificationsEnabled = granted
                if !granted {
                    self.showingNotificationAlert = true
                }
            }
        }
    }
    
    private func openAppSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
