//
//  StampSheetView.swift
//  seyyah
//
//  Created by Semih Kesgin on 30.07.2024.
//

import SwiftUI

struct StampSheet: View {
    let locationName: String
    let stamps: [String] // Example stamps
    
    var body: some View {
        VStack {
            Text("Damgalar: \(locationName)")
                .font(.headline)
                .padding()
            
            
            
            Spacer()
        }
        .padding()
    }
}
