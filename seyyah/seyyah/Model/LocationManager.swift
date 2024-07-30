import SwiftUI
import MapKit
import CoreLocation

// Model
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var userLocation: CLLocation? = nil
    @Published var welcomeMessage: String? = nil
    
    private var geofenceRegions: [CLCircularRegion] = []
    private let geofenceLocations: [(CLLocationCoordinate2D, CLLocationDistance, String)] = [
        (CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), 1000, "San Francisco"),
        (CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), 500, "Los Angeles"),
        (CLLocationCoordinate2D(latitude: 41.26900, longitude: 28.741), 100, "Istanbul Airport"), // İstanbul Havalimanı
        (CLLocationCoordinate2D(latitude: 41.0085, longitude: 28.9802), 500, "Hagia Sophia") // Ayasofya
        // Add more geofence locations here
    ]
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupGeofences()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
        region.center = location.coordinate
        checkGeofenceStatus()
    }
    
    func setupGeofences() {
        for (coordinate, radius, _) in geofenceLocations {
            let geofenceRegion = CLCircularRegion(center: coordinate, radius: radius, identifier: UUID().uuidString)
            geofenceRegion.notifyOnEntry = true
            geofenceRegion.notifyOnExit = true
            
            geofenceRegions.append(geofenceRegion)
            locationManager.startMonitoring(for: geofenceRegion)
        }
    }
    
    func checkGeofenceStatus() {
        guard let userLocation = userLocation else { return }
        
        for (coordinate, radius, name) in geofenceLocations {
            let distance = userLocation.distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            if distance <= radius {
                welcomeMessage = " \(name)'a Hoşgeldiniz"
                return
            }
        }
        welcomeMessage = nil
    }
    
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        welcomeMessage = nil
    }
}
