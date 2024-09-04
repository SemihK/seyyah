//
//  HomeView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//

import SwiftUI
import MapKit

struct HomeView: View {
   
   
    var body: some View {

        @StateObject var viewModel = ContentViewModel()
    
        var userName: String {
            UserDefaults.standard.string(forKey: "userName") ?? "Traveller"
        }
            VStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                ZStack {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(width: 320, height: 90)
                        .foregroundColor(.gray.opacity(0.1))
                    
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
            // MARK harita görünümü gelecek kullanıcının nerede olduğunu göstereceğiz.
                ZStack {
                                   RoundedRectangle(cornerRadius: 20.0)
                                       .frame(width: 320, height: 200)
                                       .foregroundColor(.gray.opacity(0.1))
                                   
                                   Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true)
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
            .padding(.top, -230)
            
            
            // MARK
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: 320, height: 200)
                .foregroundColor(.gray.opacity(0.1))
                .padding(.top, 200)
        }
        
    }

        .navigationBarBackButtonHidden(true)
        

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
