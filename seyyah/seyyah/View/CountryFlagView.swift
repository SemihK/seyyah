//
//  CountryFlagView.swift
//  seyyah
//
//  Created by semihkesgin on 11.09.2024.
//

import SwiftUI

struct CountrySelectionView: View {
    @Binding var selectedCountryFlag: String
    
    // ülkeler ve bayraklar
    let countries = [
        "USA": "🇺🇸",
        "Germany": "🇩🇪",
        "Turkey": "🇹🇷",
        "Japan": "🇯🇵",
        "France": "🇫🇷",
        "Canada": "🇨🇦",
        "UK": "🇬🇧",
        "Brazil": "🇧🇷",
        "Italy": "🇮🇹",
        "Spain": "🇪🇸",
        "Australia": "🇦🇺",
        "China": "🇨🇳",
        "India": "🇮🇳",
        "Mexico": "🇲🇽",
        "Russia": "🇷🇺",
        "South Africa": "🇿🇦",
        "Argentina": "🇦🇷",
        "Belgium": "🇧🇪",
        "Netherlands": "🇳🇱",
        "Sweden": "🇸🇪",
        "Norway": "🇳🇴",
        "Switzerland": "🇨🇭",
        "Greece": "🇬🇷",
        "Portugal": "🇵🇹",
        "Poland": "🇵🇱",
        "Czech Republic": "🇨🇿",
        "Hungary": "🇭🇺",
        "Denmark": "🇩🇰",
        "Ireland": "🇮🇪",
        "New Zealand": "🇳🇿",
        "Singapore": "🇸🇬",
        "Malaysia": "🇲🇾",
        "Thailand": "🇹🇭",
        "Vietnam": "🇻🇳",
        "Philippines": "🇵🇭",
        "Saudi Arabia": "🇸🇦",
        "United Arab Emirates": "🇦🇪",
        "Jordan": "🇯🇴",
        "Pakistan": "🇵🇰",
        "Bangladesh": "🇧🇩",
        "Sri Lanka": "🇱🇰",
        "Iran": "🇮🇷",
        "Iraq": "🇮🇶",
        "Kuwait": "🇰🇼",
        "Qatar": "🇶🇦",
        "Oman": "🇴🇲",
        "Yemen": "🇾🇪",
        "Libya": "🇱🇾",
        "Egypt": "🇪🇬",
        "Morocco": "🇲🇦",
        "Algeria": "🇩🇿",
        "Tunisia": "🇹🇳",
        "Kenya": "🇰🇪",
        "Nigeria": "🇳🇬",
        "Ghana": "🇬🇭",
        "Ivory Coast": "🇨🇮",
        "Senegal": "🇸🇳",
        "Cameroon": "🇨🇲",
        "Zimbabwe": "🇿🇼",
        "Botswana": "🇧🇼",
        "Namibia": "🇳🇦",
        "Mozambique": "🇲🇿",
        "Angola": "🇦🇴",
        "Ethiopia": "🇪🇹",
        "South Sudan": "🇸🇸",
        "Sudan": "🇸🇩",
        "Central African Republic": "🇨🇫",
        "Mali": "🇲🇱",
        "Burkina Faso": "🇧🇫",
        "Niger": "🇳🇪",
        "Chad": "🇹🇩",
        "Mauritania": "🇲🇷",
        "Guinea": "🇬🇳",
        "Sierra Leone": "🇸🇱",
        "Liberia": "🇱🇸",
        "Cape Verde": "🇨🇻",
        "Saint Kitts and Nevis": "🇰🇳",
        "Saint Lucia": "🇱🇨",
        "Saint Vincent and the Grenadines": "🇻🇨",
        "Barbados": "🇧🇧",
        "Trinidad and Tobago": "🇹🇹",
        "Jamaica": "🇯🇲",
        "Bahamas": "🇧🇸",
        "Haiti": "🇭🇹",
        "Dominican Republic": "🇩🇴",
        "Cuba": "🇨🇺",
        "Puerto Rico": "🇵🇷",
        "Greenland": "🇬🇱",
        "Armenia": "🇦🇲",
        "Georgia": "🇬🇪",
        "Azerbaijan": "🇦🇿",
        "Uzbekistan": "🇺🇿",
        "Kazakhstan": "🇰🇿",
        "Turkmenistan": "🇹🇲",
        "Kyrgyzstan": "🇰🇬",
        "Tajikistan": "🇹🇯",
        "Afghanistan": "🇦🇫",
        "Bhutan": "🇧🇹",
        "Maldives": "🇲🇻",
        "Brunei": "🇧🇳",
        "Laos": "🇱🇦",
        "Myanmar": "🇲🇲",
        "Cambodia": "🇰🇭",
        "Nepal": "🇳🇵",
        "Syria": "🇸🇾",
        "Lebanon": "🇱🇧",
        "Palestine": "🇵🇸"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()) // Her satırda 3 sütun olacak
    ]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select your country for digital passport.")
                .tint(.pink)
                .foregroundStyle(.backgroundText)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(countries.keys.sorted(), id: \.self) { country in
                        VStack {
                            Text(countries[country] ?? "")
                                .font(.system(size: 50)) // Bayrak büyüklüğü
                            
                            Text(country)
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedCountryFlag == countries[country] ? Color.gray.opacity(0.2) : Color.clear)
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedCountryFlag = countries[country] ?? "🇺🇸"
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Button("Save Country") {
                saveCountrySelection()
                dismiss() // Sheet'i kapat
            }
            .padding(.top)
        }
        .padding()
    }
    
    func saveCountrySelection() {
        UserDefaults.standard.set(selectedCountryFlag, forKey: "selectedCountry")
        print("Selected country saved: \(selectedCountryFlag)")
    }
}

#Preview {
    CountrySelectionView(selectedCountryFlag: .constant("🇹🇷"))
}

