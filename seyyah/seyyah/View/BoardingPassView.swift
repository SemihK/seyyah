//
//  BoardingPassView.swift
//  seyyah
//
//  Created by Semih Kesgin on 2.08.2024.
//

import SwiftUI

struct BoardingPassView: View {
    @State private var showingSheet = false
    @State private var locationName = "Istanbul Airport"
    
    var body: some View {
        
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: 400, height: 50)
                    .foregroundColor(.black)
                
                HStack(spacing: 0) {
                    Text("BOARDING")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("PASS")
                        .font(.headline)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
            }
            
            .padding()
            
            // Flight Route
            ZStack {
                        Image("worldmap")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                            .blur(radius: 1)
                        
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("IST")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    
                                    Text("Departure")
                                        .font(.caption)
                                }
                                
                                Spacer()
                                
                                ZStack {
                                    Canvas { context, size in
                                        let startPoint = CGPoint(x: 0, y: size.height / 2)
                                        let endPoint = CGPoint(x: size.width, y: size.height / 2)
                                        let controlPoint = CGPoint(x: size.width / 2, y: -size.height / 2)
                                        
                                        var path = Path()
                                        path.move(to: startPoint)
                                        
                                        // Parabolik bir eğri
                                        path.addQuadCurve(to: endPoint, control: controlPoint)
                                        
                                        context.stroke(path, with: .color(.black), lineWidth: 2)
                                    }
                                    .frame(width: 150, height: 30) // Uygun genişlik ve yükseklik ayarı

                                    Image(systemName: "airplane")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                        .offset(x: 0, y: -15) // Logo’yu çizginin tam ortasında yerleştirmek için ayarla
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("AYT")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Text("Arrival")
                                        .font(.caption)
                                }
                            }
                            .padding()
                           
                            HStack {
                                Spacer()
                                Text("2h 30m Flight Time")
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.white)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.purple, .blue],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(5)
                                
                                Spacer()
                            }
                        }
                    }
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    Spacer()
            
            // Flight Time
            HStack {
                VStack(alignment: .leading) {
                    Text("5:10 AM")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("San Francisco")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text("September, 13")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("4:10 PM")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Madrid")
                        .font(.caption)
                        .foregroundColor(.white)
                    Text("September, 13")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.purple)
            .cornerRadius(15)
            .padding(.horizontal)
            
            Spacer()
            // Passenger Information
            VStack(alignment: .leading, spacing: 10) {
                Text("John Wick")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("First Class")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Divider()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Flight")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("SE 23")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Terminal")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("5")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Gate")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("12A")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Seat")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("32E")
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.horizontal)
            
            Spacer()
            // Virtual Airplane Map Button
            Button(action: {
                showingSheet = true
            }) {
                HStack {
                    Image(systemName: "magazine.fill")
                    Text("PASSPORT")
                        .font(.headline)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.purple, .blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )

                    
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding(.horizontal)
            .sheet(isPresented: $showingSheet) {
                StampSheet(locationName: locationName, stamps: ["Stamp 1", "Stamp 2", "Stamp 3"])
            }
            
            Spacer()
            
            // Bottom Navigation
            HStack {
                Button(action: {
                    // Action for button
                }) {
                    Image(systemName: "airplane")
                }
                Spacer()
                Button(action: {
                    // Action for button
                }) {
                    Image(systemName: "ticket")
                }
                Spacer()
                Button(action: {
                    // Action for button
                }) {
                    Image(systemName: "gear")
                }
            }
            .padding()
            .foregroundStyle(.black)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.horizontal)
            
        }
        .background(Color.white
            .ignoresSafeArea())
    }
    
    struct BoardingPassView_Previews: PreviewProvider {
        static var previews: some View {
            BoardingPassView()
        }
    }
}
