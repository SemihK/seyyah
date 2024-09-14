//
//  PassportView.swift
//  seyyah
//
//  Created by semihkesgin on 5.09.2024.
//
import SwiftUI

struct StatisticsView: View {
    @Environment(\.colorScheme) var colorScheme
    // Örnek veri
    let totalTrips: Int = 12
    let visitedCountries: Int = 8
    let passportStamps: Int = 15
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: 320, height: 200)
                .foregroundColor(.black)
                .overlay(
                    VStack(spacing: 20) {
                        Text("Your Passport Stats")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .padding(.top, 20)
                        
                        HStack {
                            StatisticItem(title: "Total Trips", value: "\(totalTrips)")
                            StatisticItem(title: "Visited Countries", value: "\(visitedCountries)")
                            StatisticItem(title: "Stamps", value: "\(passportStamps)")
                        }
                    }
                    .padding()
                )
                .padding(.top, 200)
        }
    }
}

struct StatisticItem: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .black : .black)
            Text(value)
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? .black : .black)
                .bold()
        }
         .frame(width: 55, height: 80)
        .padding()
        .background(colorScheme == .dark ? Color.white : Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    StatisticsView()
}



#Preview {
    StatisticsView()
}
