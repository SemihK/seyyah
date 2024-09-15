//
//  HomeView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//

import SwiftUI
import MapKit
import UserNotifications

struct HomeView: View {
    
    @State private var isNotificationPermissionRequested = false
    @State private var showNotificationExplanationSheet = false
    @StateObject private var viewModel = ContentViewModel()
    @State private var region = MKCoordinateRegion(
        center: .init(latitude: 41.27224275, longitude: 28.73492786),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    private var userName: String {
        UserDefaults.standard.string(forKey: "userName") ?? "Traveller"
    }
    var body: some View {
        
        VStack (spacing: 20){
            ZStack {
                Color.background
                    .ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(width: 320, height: 90)
                        .foregroundColor(.background)
                    
                    HStack(alignment: .center) {
                        Image(systemName: greetingImageName)
                            .foregroundStyle(greetingImageColor)
                        
                        Text(greetingMessage)
                            .font(.headline)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.red, .purple, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                    }
                }
                
                
                
                
                .padding(.top, -350)
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(width: 320, height: 200)
                        .foregroundColor(.gray.opacity(0.1))
                    
                    Map(
                        coordinateRegion: $region,
                        showsUserLocation: true,
                        userTrackingMode: .constant(.follow)
                    )
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        viewModel.checkIfLocationIsEnabled()
                    }
                    .mapControls {
                        MapUserLocationButton()
                        
                    }
                    .mapStyle(
                        .standard(
                            elevation: .flat,
                            pointsOfInterest: .including([.airport]),
                            showsTraffic: false
                        ))
                }
                .clipShape(.buttonBorder)
                .frame(width: 320, height: 200)
                .foregroundColor(.gray.opacity(0.1))
                .padding(.bottom, 250)
                
                
                // MARK
                ZStack{
                    StatisticsView()
                }
            }
            
        }
        
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !isNotificationPermissionRequested {
                requestNotificationPermission()
            }
        }
        .sheet(isPresented: $showNotificationExplanationSheet) {
            NotificationExplanationView()
        }
        
    }
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                self.isNotificationPermissionRequested = true
                if !granted {
                    self.showNotificationExplanationSheet = true
                }
            }
        }
    }
    
    func checkIfOnboardingCompleted() {
        let onboardingCompleted = UserDefaults.standard.bool(forKey: "onboardingCompleted")
        if !onboardingCompleted {
            // Kullanıcı onboarding'i tamamlamadıysa, onboarding ekranına geri dön
            // Burada Navigation veya diğer yöntemlerle yönlendirme yapılabilir
            print("Kullanıcı onboarding'e yönlendirilecek.")
        }
    }
    
    
    final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        var locationManager: CLLocationManager?
        
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.27224275, longitude: 28.73492786), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        func checkIfLocationIsEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                locationManager = CLLocationManager()
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                locationManager?.delegate = self
                locationManager?.requestWhenInUseAuthorization()
            } else {
                print("Lokasyon açık değil.")
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                print("Location permission denied or restricted.")
            case .authorizedAlways, .authorizedWhenInUse:
                if let location = manager.location {
                    mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }
            @unknown default:
                break
            }
        }
    }
    
    
}
    #Preview {
        HomeView()
        
    }

