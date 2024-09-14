//
//  AlternativeHomeView.swift
//  seyyah
//
//  Created by semihkesgin on 5.09.2024.
//

import SwiftUI
import MapKit
import Drawer

struct AlternativeHomeView: View {
    
    @State var region = MKCoordinateRegion(
            center: .init(latitude: 41.27224275,longitude: 28.73492786),
            span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    
    
    var body: some View {
        
        ZStack {
            Map(
                coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow)
            )
            
            
            .mapControls {
                MapUserLocationButton()
                
            }
            .mapStyle(
                .standard(
                    elevation: .flat,
                    pointsOfInterest: .including([.airport]),
                    showsTraffic: false
                ))
            .ignoresSafeArea()
            
            Drawer {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .shadow(radius: 100)
                  
                    PassportSheetView()
                    
                    VStack(alignment: .center) {
                        Spacer().frame(height: 4.0)
                        RoundedRectangle(cornerRadius: 3.0)
                            .foregroundColor(.gray)
                            .frame(width: 30.0, height: 6.0)
                        Spacer()
                    }
                }
                
            }
            .rest(at: .constant([100, 340, UIScreen.main.bounds.height - 40]))
            .impact(.light)
        }
    }
}

#Preview {
    AlternativeHomeView()
}
