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
            (CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784), 100, "Hagia Sophia"), // Ayasofya
            (CLLocationCoordinate2D(latitude: 41.0054, longitude: 28.9778), 100, "Blue Mosque"), // Sultan Ahmet Camii
            (CLLocationCoordinate2D(latitude: 41.0096, longitude: 28.9654), 200, "Topkapi Palace"), // Topkapı Sarayı
            (CLLocationCoordinate2D(latitude: 41.0151, longitude: 28.9794), 300, "Basilica Cistern"), // Yerebatan Sarnıcı
            (CLLocationCoordinate2D(latitude: 41.0138, longitude: 28.9794), 150, "Grand Bazaar"), // Kapalıçarşı
            (CLLocationCoordinate2D(latitude: 41.0311, longitude: 28.9784), 150, "Galata Tower"), // Galata Kulesi
            (CLLocationCoordinate2D(latitude: 41.0532, longitude: 28.9784), 200, "Dolmabahce Palace"), // Dolmabahçe Sarayı
            (CLLocationCoordinate2D(latitude: 41.0369, longitude: 28.9755), 100, "Süleymaniye Mosque"), // Süleymaniye Camii
            (CLLocationCoordinate2D(latitude: 41.0327, longitude: 28.9806), 100, "Taksim Square"), // Taksim Meydanı
            (CLLocationCoordinate2D(latitude: 41.0319, longitude: 28.9813), 150, "Istiklal Avenue") // İstiklal Caddesi
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
