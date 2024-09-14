//
//  dummy.swift
//  seyyah
//
//  Created by semihkesgin on 11.09.2024.
//

import Foundation
/*
 //
 //  PassportView.swift
 //  seyyah
 //
 //  Created by semihkesgin on 5.09.2024.
 //

 import SwiftUI

 struct PassportPage: View {
     let pageNumber: Int
     let content: String
     
     var body: some View {
         VStack {
             Text("Sayfa \(pageNumber)")
                 .font(.headline)
             
             Text(content)
                 .padding()
             
             Spacer()
         }
         .frame(width: 300, height: 400)
         .background(Color(red: 0.95, green: 0.95, blue: 0.87))
         .cornerRadius(5)
         .shadow(color: .gray, radius: 2, x: 0, y: 2)
     }
 }

 struct PassportView: View {
     @State private var currentPage = 0
     let totalPages = 10
     
     var body: some View {
         VStack {
             ZStack {
                 // Pasaport kapağı
                 RoundedRectangle(cornerRadius: 10)
                     .fill(Color.background)
                     .frame(width: 320, height: 440)
                     .shadow(radius: 10)
                 
                 // Sayfalar
                 ForEach((0..<totalPages).reversed(), id: \.self) { index in
                     PassportPage(pageNumber: index + 1, content: "Pasaport sayfası \(index + 1) içeriği")
                         .rotation3DEffect(
                             .degrees(currentPage == index ? 0 : 90),
                             axis: (x: 0, y: 1, z: 0),
                             anchor: .leading,
                             perspective: 0.5
                         )
                         .animation(.spring(), value: currentPage)
                 }
             }
             .frame(width: 320, height: 440)
             
             HStack {
                 Button(action: {
                     if currentPage > 0 {
                         withAnimation {
                             currentPage -= 1
                         }
                     }
                 }) {
                     Image(systemName: "chevron.left")
                         .foregroundColor(.blue)
                 }
                 .disabled(currentPage == 0)
                 
                 Spacer()
                 
                 Text("\(currentPage + 1) / \(totalPages)")
                 
                 Spacer()
                 
                 Button(action: {
                     if currentPage < totalPages - 1 {
                         withAnimation {
                             currentPage += 1
                         }
                     }
                 }) {
                     Image(systemName: "chevron.right")
                         .foregroundColor(.blue)
                 }
                 .disabled(currentPage == totalPages - 1)
             }
             .padding()
             .frame(width: 320)
         }
     }
 }



 #Preview {
     PassportView()
 }

 */
