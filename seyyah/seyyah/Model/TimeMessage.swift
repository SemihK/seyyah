//
//  TimeMessage.swift
//  seyyah
//
//  Created by semihkesgin on 4.09.2024.
//

import Foundation
import SwiftUI
var userName: String {
        UserDefaults.standard.string(forKey: "userName") ?? "Traveller"
    }

var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            return "Good Morning \(userName)"
        case 12..<18:
            return "Good Afternoon \(userName)"
        case 18..<23:
            return "Good Evening \(userName)"
        case 0..<6:
            return "Good Night \(userName)"
        default:
            return "Good Night \(userName)"
        }
    }

var greetingImageName: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            return "sunrise.fill"
        case 12..<18:
            return "sun.max.fill"
        case 18..<22:
            return "sunset.fill"
        default:
            return "moon.stars.fill"
        }
    }

var greetingImageColor: Color {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            return .orange
        case 12..<18:
            return .yellow
        case 18..<22:
            return .orange
        default:
            return .blue
        }
    }
