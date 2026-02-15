//
//  AdaptiveColors.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/14/26.
//

import SwiftUI

/// Simple, direct adaptive colors that DEFINITELY work
struct AdaptiveColors {
    @Environment(\.colorScheme) var colorScheme
    
    var background: Color {
        colorScheme == .light ? Color.white : Color(hex: "0D0D0D")
    }
    
    var surface: Color {
        colorScheme == .light ? Color(hex: "F5F5F5") : Color(hex: "1A1A1A")
    }
    
    var textPrimary: Color {
        colorScheme == .light ? Color(hex: "1A1A1A") : Color(hex: "E8E6E3")
    }
    
    var textSecondary: Color {
        colorScheme == .light ? Color(hex: "666666") : Color(hex: "8A8A7A")
    }
    
    var border: Color {
        colorScheme == .light ? Color(hex: "E0E0E0") : Color(hex: "2A2A2A")
    }
    
    // Accent stays same
    var accent: Color {
        Color(hex: "9BAA7F")
    }
}

// View extension for easy access
extension View {
    @ViewBuilder
    func withAdaptiveBackground() -> some View {
        self.background(Color.adaptiveBackground)
    }
}

// Color extension for static access
extension Color {
    static var adaptiveBackground: Color {
        Color(uiColor: .systemBackground)
    }
    
    static var adaptiveSurface: Color {
        Color(uiColor: .secondarySystemBackground)
    }
    
    static var adaptiveTextPrimary: Color {
        Color(uiColor: .label)
    }
    
    static var adaptiveTextSecondary: Color {
        Color(uiColor: .secondaryLabel)
    }
}
