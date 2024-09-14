//
//  PassportView.swift
//  seyyah
//
//  Created by semihkesgin on 5.09.2024.
//

import SwiftUI

struct PassportStampView: View {
    let stampImage: String
    let stampText: String
    
    var body: some View {
        VStack {
            Image(systemName: stampImage)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            Text(stampText)
                .font(.title)
                .padding()
        }
    }
}

struct PassportSheetView: View {
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack {
            Button(action: {
                isSheetPresented = true
            }) {
                Text("Pasaport Mühürlerini Göster")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            TabView {
                Image("Istanbul-Stamp")
                    .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    .tabItem {
                        Text("Sayfa 1")
                    }
                
                PassportStampView(stampImage: "airplane", stampText: "Uçak Mührü")
                    .tabItem {
                        Text("Sayfa 2")
                    }
                
                PassportStampView(stampImage: "star", stampText: "Yıldız Mührü")
                    .tabItem {
                        Text("Sayfa 3")
                    }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}




#Preview {
    PassportSheetView()
}
