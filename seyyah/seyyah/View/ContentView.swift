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
        if let message = locationManager.welcomeMessage {
            return message
        } else if locationManager.userLocation != nil {
            return "Kullanıcı Adı gelecek"
        } else {
            return "Kullanıcı Adı"
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
