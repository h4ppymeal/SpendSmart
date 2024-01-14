//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Bethany Liu on 2023-12-25.
//

import Foundation
import SwiftUI

// Extension on the Color type to define custom color properties.
extension Color {
    static let backgroundColor = Color("Background")
    static let iconColor = Color("Icon")
    static let textColor = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

// Extension on the DateFormatter type to define a custom date formatter with a specific format.
extension DateFormatter {
    // Static property to create a date formatter with the "MM/dd/yyyy" format.
    // The formatter is lazily initialized using a closure.
    static let allNumericUSA: DateFormatter = {
        // Print a message indicating the initialization of the DateFormatter.
        print("Initializing DateFormatter")
        
        // Create and configure the date formatter.
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        // Return the configured date formatter.
        return formatter
    }()
}

// Extension on the String type to add a method for parsing a date from a string.
extension String {
    // Method to parse a date from the string using the custom date formatter.
    func dateParsed() -> Date {
        // Attempt to parse the date from the string using the custom date formatter.
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else {
            // If parsing fails, return the current date.
            return Date()
        }
        
        // Return the parsed date.
        return parsedDate
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundedTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}
