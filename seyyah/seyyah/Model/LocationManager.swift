//
//  LocationManager.swift
//  seyyah
//
//  Created by Semih Kesgin on 30.07.2024.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var userLocation: CLLocation? = nil
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupGeofence()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
        region.center = location.coordinate
    }
    
    func setupGeofence() {
        // Define a geofence region
        let geofenceCenter = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // Example coordinates
        let geofenceRadius: CLLocationDistance = 1000 // 1 km
        let geofenceRegion = CLCircularRegion(center: geofenceCenter, radius: geofenceRadius, identifier: "Geofence")
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        locationManager.startMonitoring(for: geofenceRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // Handle geofence entry
        print("Entered geofence region")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        // Handle geofence exit
        print("Exited geofence region")
    }
}
