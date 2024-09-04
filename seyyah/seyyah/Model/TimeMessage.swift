//
//  TimeMessage.swift
//  seyyah
//
//  Created by semihkesgin on 4.09.2024.
//

import Foundation
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
        case 18..<22:
            return "Good Evening \(userName)"
        default:
            return "Good Day \(userName)"
        }
    }
