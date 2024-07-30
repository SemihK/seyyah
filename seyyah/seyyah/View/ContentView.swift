import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            HeaderView(userLocationText: userLocationText)
            MapView(region: $locationManager.region)
            Spacer()
                .padding()
        }
    }
    
    private var userLocationText: String {
        if let location = locationManager.userLocation {
            return "Lat: \(location.coordinate.latitude), Lon: \(location.coordinate.longitude)"
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
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
