//
//  RoleSelectionView.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/3/26.
//

import SwiftUI

struct RoleSelectionView: View {
    @ObservedObject private var authManager = AuthenticationManager.shared
    @State private var selectedRole: UserRole?
    @State private var showingMain = false
    
    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()
            
            VStack(spacing: Theme.Spacing.xl) {
                Spacer()
                
                // Header
                VStack(spacing: Theme.Spacing.md) {
                    if let xProfile = authManager.xProfile {
                        Text("> welcome, @\(xProfile.username)")
                            .font(Theme.Typography.heading)
                            .foregroundColor(Theme.Colors.accent)
                    } else {
                        Text("> choose your role")
                            .font(Theme.Typography.heading)
                            .foregroundColor(Theme.Colors.accent)
                    }
                    
                    Text("HOW DO YOU WANT TO USE SOLOMINE?")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                
                Spacer()
                
                // Role selection cards
                VStack(spacing: Theme.Spacing.md) {
                    // I Build
                    RoleCard(
                        role: .builder,
                        icon: "terminal",
                        title: "I BUILD",
                        description: "I'm a freelancer looking for clients and projects",
                        features: [
                            "Create your dev profile",
                            "List your services & gigs",
                            "Get hired by companies",
                            "Build your reputation"
                        ],
                        isSelected: selectedRole == .builder
                    ) {
                        selectedRole = .builder
                    }
                    
                    // I Hire
                    RoleCard(
                        role: .hirer,
                        icon: "building.2",
                        title: "I HIRE",
                        description: "I'm looking to hire developers for projects",
                        features: [
                            "Browse top developers",
                            "Review portfolios & skills",
                            "Hire with Apple Pay",
                            "Manage your projects"
                        ],
                        isSelected: selectedRole == .hirer
                    ) {
                        selectedRole = .hirer
                    }
                }
                .padding(.horizontal, Theme.Spacing.md)
                
                Spacer()
                
                // Continue button
                if let role = selectedRole {
                    TerminalButton("CONTINUE AS \(role.rawValue)") {
                        completeOnboarding(role: role)
                    }
                    .padding(.horizontal, Theme.Spacing.xl)
                } else {
                    Text("> select a role to continue_")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showingMain) {
            MainTabView()
                .environmentObject(authManager)
        }
    }
    
    private func completeOnboarding(role: UserRole) {
        // Update user with selected role
        if var user = authManager.currentUser {
            user.role = role
            
            // If builder, pre-fill from X profile with all X data
            if role == .builder, let xProfile = authManager.xProfile {
                user.freelancerProfile = FreelancerProfile(
                    xUsername: xProfile.username,
                    displayName: xProfile.displayName,
                    bio: xProfile.bio ?? "Developer on Solomine",
                    skills: [],
                    xFollowers: xProfile.followers,
                    xFollowing: xProfile.following,
                    xVerified: xProfile.verified,
                    xProfileImageURL: xProfile.profileImageURL
                )
            }
            
            authManager.currentUser = user
        }
        
        showingMain = true
    }
}

struct RoleCard: View {
    let role: UserRole
    let icon: String
    let title: String
    let description: String
    let features: [String]
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                // Header
                HStack(spacing: Theme.Spacing.sm) {
                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .bold, design: .monospaced))
                        .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.accent)
                    
                    VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                        Text(title)
                            .font(Theme.Typography.heading)
                            .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.textPrimary)
                        
                        Text(description)
                            .font(Theme.Typography.tiny)
                            .foregroundColor(isSelected ? Theme.Colors.background.opacity(0.8) : Theme.Colors.textSecondary)
                    }
                    
                    Spacer()
                }
                
                // Features
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    ForEach(features, id: \.self) { feature in
                        HStack(spacing: Theme.Spacing.xs) {
                            Text(isSelected ? ">" : "•")
                                .font(Theme.Typography.caption)
                                .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.accent)
                            
                            Text(feature)
                                .font(Theme.Typography.caption)
                                .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.textSecondary)
                        }
                    }
                }
            }
            .padding(Theme.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isSelected ? Theme.Colors.accent : Theme.Colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                    .stroke(Theme.Colors.accent, lineWidth: isSelected ? Theme.BorderWidth.medium : Theme.BorderWidth.thin)
            )
            .cornerRadius(Theme.CornerRadius.medium)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    RoleSelectionView()
}
