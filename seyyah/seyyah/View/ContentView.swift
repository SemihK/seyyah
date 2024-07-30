import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            HeaderView(userLocationText: userLocationText)
            MapView(region: $locationManager.region)
                .onChange(of: locationManager.welcomeMessage) { _ in
                    if locationManager.welcomeMessage != nil {
                        showingSheet = true
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    if let locationName = locationManager.welcomeMessage {
                        // Example stamps for the location
                        let stamps = ["Stamp 1", "Stamp 2", "Stamp 3"]
                        StampSheet(locationName: locationName, stamps: stamps)
                    }
                }
            
            Spacer()
                .padding()
        }
    }
    
    private var userLocationText: String {
        if let message = locationManager.welcomeMessage {
            return message
        } else if locationManager.userLocation != nil {
            return "Konum Bilgisi Alınıyor..."
        } else {
            return "Konum Bilgisi Alınıyor..."
        }
    }
}

struct HeaderView: View {
    let userLocationText: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 1000, height: 50)
                .foregroundColor(.yellow)
                .cornerRadius(10)
                .shadow(radius: 10)
            Text(userLocationText)
                .font(.title2)
                .foregroundColor(.white)
                .bold()
                .padding()
        }
    }
}

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        ZStack {
            if #available(iOS 17.0, *) {
                Map(coordinateRegion: $region, showsUserLocation: true)
                    .frame(width: 1000, height: 500)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .mapStyle(.standard(elevation: .realistic))
            } else {
                // Fallback on earlier versions
                Text("Map not available on this iOS version.")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
