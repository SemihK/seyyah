//
//  StampSheetView.swift
//  seyyah
//
//  Created by Semih Kesgin on 30.07.2024.
//

import SwiftUI

struct StampSheet: View {
    let locationName: String
    let stamps: [String]
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(locationName)")
                .font(.headline)
                .padding()
            
            Rectangle()
                            .frame(width: 300, height: 400)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .overlay(
                                VStack {
                                    // Passport Title
                                    Text("PASSPORT")
                                        .font(.headline)
                                        .padding(.top, 20)
                                    
                                    Spacer()
                                    
                                    // Passport Content
                                    VStack(alignment: .leading) {
                                        Text("Name: Semih Kesgin")
                                        
                                        
                                        
                                    }
                                    .padding()
                                    
                                    Spacer()
                                    
                                    // Passport Footer
                                    Text("Authorized Signature")
                                        .font(.subheadline)
                                        .padding(.bottom, 20)
                                }
                            )
            
            Spacer()
        }
        .padding()
    }
}

struct StampSheet_Previews: PreviewProvider {
    static var previews: some View {
        StampSheet(locationName: "Istanbul Airport", stamps: ["Stamp 1", "Stamp 2", "Stamp 3"])
    }
}
