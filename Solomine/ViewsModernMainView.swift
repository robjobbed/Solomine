//
//  ModernMainView.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/3/26.
//

import SwiftUI

struct ModernMainView: View {
    @State private var selectedTab: MainTab = .explore
    @State private var showingDrawer = false
    @StateObject private var authManager = AuthenticationManager.shared
    @AppStorage("preferredColorScheme") private var preferredColorScheme: String = "dark"
    @State private var isTransitioning = false
    @Environment(\.colorScheme) var systemColorScheme
    
    private var colorScheme: ColorScheme? {
        switch preferredColorScheme {
        case "light": return .light
        case "dark": return .dark
        default: return nil // System default
        }
    }
    
    private var currentColorScheme: ColorScheme {
        colorScheme ?? systemColorScheme
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Base background that WILL change color
                (currentColorScheme == .light ? Color.white : Color.black)
                    .ignoresSafeArea()
                
                // Main content
                Group {
                    switch selectedTab {
                    case .explore:
                        ExploreView()
                            .environmentObject(authManager)
                    case .gigs:
                        GigsView()
                    case .messages:
                        MessagesView()
                    case .dashboard:
                        DashboardView()
                    case .profile:
                        ProfileView()
                            .environmentObject(authManager)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .id(preferredColorScheme) // Force view refresh on theme change
                
                // Theme transition overlay
                if isTransitioning {
                    (currentColorScheme == .light ? Color.white : Color.black)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .zIndex(999)
                }
                
                // Drawer overlay
                if showingDrawer {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                showingDrawer = false
                            }
                        }
                    
                    DrawerMenu(
                        selectedTab: $selectedTab, 
                        isShowing: $showingDrawer,
                        preferredColorScheme: $preferredColorScheme,
                        onThemeChange: changeTheme
                    )
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            showingDrawer.toggle()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Theme.Colors.surface)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Theme.Colors.accent, lineWidth: 1)
                                )
                            
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 18, weight: .bold, design: .monospaced))
                                .foregroundColor(Theme.Colors.accent)
                        }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 4) {
                        Text(selectedTab.title.uppercased())
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.accent)
                            .kerning(2)
                            .animation(.easeInOut(duration: 0.2), value: selectedTab)
                        
                        BlinkingCursor()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if let xProfile = authManager.xProfile {
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedTab = .profile
                            }
                        }) {
                            HStack(spacing: 4) {
                                if xProfile.verified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Theme.Colors.accent)
                                }
                                
                                Text("@\(xProfile.username)")
                                    .font(Theme.Typography.tiny)
                                    .foregroundColor(Theme.Colors.accent)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Theme.Colors.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(Theme.Colors.accent, lineWidth: 1)
                            )
                            .cornerRadius(3)
                        }
                    }
                }
            }
            .toolbarBackground(Theme.Colors.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(colorScheme)
    }
    
    // MARK: - Helper Functions
    
    private func changeTheme(to newTheme: String) {
        print("🎨 Changing theme to: \(newTheme)")
        
        // Haptic feedback
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        
        // Trigger transition overlay
        withAnimation(.easeInOut(duration: 0.15)) {
            isTransitioning = true
        }
        
        // Change theme after brief delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            preferredColorScheme = newTheme
            print("✅ Theme set to: \(self.preferredColorScheme), colorScheme: \(String(describing: self.colorScheme))")
            
            // Remove transition overlay
            withAnimation(.easeInOut(duration: 0.15)) {
                isTransitioning = false
            }
        }
    }
}

struct DrawerMenu: View {
    @Binding var selectedTab: MainTab
    @Binding var isShowing: Bool
    @Binding var preferredColorScheme: String
    let onThemeChange: (String) -> Void
    @StateObject private var authManager = AuthenticationManager.shared
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 12) {
                    Text("SOLOMINE")
                        .font(.system(size: 24, weight: .bold, design: .monospaced))
                        .foregroundColor(Theme.Colors.accent)
                        .kerning(3)
                    
                    if let xProfile = authManager.xProfile {
                        HStack(spacing: 6) {
                            Image(systemName: "bird.fill")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Theme.Colors.accent)
                            
                            Text("@\(xProfile.username)")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textPrimary)
                            
                            if xProfile.verified {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(Theme.Colors.accent)
                            }
                        }
                        
                        Text("\(formatFollowerCount(xProfile.followers)) followers")
                            .font(Theme.Typography.tiny)
                            .foregroundColor(Theme.Colors.textSecondary)
                    }
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Theme.Colors.surface)
                
                Divider()
                    .background(Theme.Colors.border)
                
                // Menu items
                ScrollView {
                    VStack(spacing: 4) {
                        ForEach(MainTab.allCases) { tab in
                            DrawerMenuItem(
                                tab: tab,
                                isSelected: selectedTab == tab,
                                action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                        selectedTab = tab
                                        isShowing = false
                                    }
                                }
                            )
                        }
                    }
                    .padding(.vertical, 12)
                }
                
                Spacer()
                
                // Theme toggle section
                VStack(spacing: 0) {
                    Divider()
                        .background(Theme.Colors.border)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("APPEARANCE")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .kerning(1)
                            
                            Spacer()
                            
                            // Debug indicator
                            Text("[\(preferredColorScheme.uppercased())]")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.accent)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                        
                        HStack(spacing: 8) {
                            // Light mode button
                            ThemeButton(
                                icon: "sun.max.fill",
                                label: "LIGHT",
                                isSelected: preferredColorScheme == "light",
                                action: {
                                    onThemeChange("light")
                                }
                            )
                            
                            // Dark mode button
                            ThemeButton(
                                icon: "moon.fill",
                                label: "DARK",
                                isSelected: preferredColorScheme == "dark",
                                action: {
                                    onThemeChange("dark")
                                }
                            )
                            
                            // System mode button
                            ThemeButton(
                                icon: "gear",
                                label: "AUTO",
                                isSelected: preferredColorScheme == "system",
                                action: {
                                    onThemeChange("system")
                                }
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 12)
                    }
                }
                
                // Footer
                VStack(spacing: 8) {
                    Divider()
                        .background(Theme.Colors.border)
                    
                    Button(action: {
                        authManager.signOut()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                            Text("LOG OUT")
                                .font(Theme.Typography.caption)
                        }
                        .foregroundColor(Theme.Colors.accentSecondary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .frame(width: 280)
            .background(Theme.Colors.background)
            .overlay(
                Rectangle()
                    .fill(Theme.Colors.accent.opacity(0.3))
                    .frame(width: 1),
                alignment: .trailing
            )
            
            Spacer()
        }
    }
    
    private func formatFollowerCount(_ count: Int) -> String {
        if count >= 1000000 {
            return String(format: "%.1fM", Double(count) / 1000000.0)
        } else if count >= 1000 {
            return String(format: "%.1fK", Double(count) / 1000.0)
        } else {
            return "\(count)"
        }
    }
}

struct DrawerMenuItem: View {
    let tab: MainTab
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: tab.icon)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.accent)
                    .frame(width: 24)
                
                Text(tab.title.uppercased())
                    .font(Theme.Typography.caption)
                    .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.textPrimary)
                    .kerning(1)
                
                Spacer()
                
                if isSelected {
                    Rectangle()
                        .fill(Theme.Colors.accent)
                        .frame(width: 4, height: 24)
                        .transition(.scale(scale: 0, anchor: .trailing).combined(with: .opacity))
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(isSelected ? Theme.Colors.accent : (isHovered ? Theme.Colors.surface : Color.clear))
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isSelected)
    }
}

enum MainTab: String, CaseIterable, Identifiable {
    case explore
    case gigs
    case messages
    case dashboard
    case profile
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .explore: return "Explore"
        case .gigs: return "Gigs"
        case .messages: return "Messages"
        case .dashboard: return "Dashboard"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .explore: return "magnifyingglass"
        case .gigs: return "briefcase.fill"
        case .messages: return "message.fill"
        case .dashboard: return "chart.bar.fill"
        case .profile: return "person.fill"
        }
    }
}

struct ThemeButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
            
            action()
        }) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.accent)
                    .frame(height: 20)
                    .scaleEffect(isPressed ? 0.85 : 1.0)
                
                Text(label)
                    .font(Theme.Typography.tiny)
                    .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.textSecondary)
                    .kerning(0.5)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isSelected ? Theme.Colors.accent : Theme.Colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(isSelected ? Theme.Colors.accent : Theme.Colors.border, lineWidth: isSelected ? 2 : 1)
            )
            .cornerRadius(6)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .shadow(color: isSelected ? Theme.Colors.accent.opacity(0.3) : .clear, radius: isSelected ? 8 : 0, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
    }
}

#Preview {
    ModernMainView()
}
