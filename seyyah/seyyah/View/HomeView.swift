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
                Map(coordinateRegion: viewModel.binding,showsUserLocation: true,userTrackingMode: .constant(.follow))
                
                    .edgesIgnoringSafeArea(.all)
                    .onAppear(perform: {
                        viewModel.checkIfLocationIsEnabled()
                        
                    })
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

        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.457105, longitude: -80.508361), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

        var binding: Binding<MKCoordinateRegion> {
            Binding {
                self.mapRegion
            } set: { newRegion in
                self.mapRegion = newRegion
            }
        }

        func checkIfLocationIsEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                locationManager = CLLocationManager()
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                locationManager!.delegate = self
            } else {
                print("Lokasyon açık değil.")
            }
        }

        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            let previousAuthorizationStatus = manager.authorizationStatus
            manager.requestWhenInUseAuthorization()
            if manager.authorizationStatus != previousAuthorizationStatus {
                checkLocationAuthorization()
            }
        }

        private func checkLocationAuthorization() {
            guard let location = locationManager else {
                return
            }

            switch location.authorizationStatus {
            case .notDetermined:
                print("Location authorization is not determined.")
            case .restricted:
                print("Location is restricted.")
            case .denied:
                print("Location permission denied.")
            case .authorizedAlways, .authorizedWhenInUse:
                if let location = location.location {
                    mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }

            default:
                break
            }
        }
    }


    
}
#Preview {
    HomeView()

}
