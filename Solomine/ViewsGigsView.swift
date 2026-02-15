//
//  GigsView.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/3/26.
//

import SwiftUI

struct GigsView: View {
    @State private var selectedCategory: GigCategory?
    @State private var selectedGig: GigListing?
    
    var gigs: [GigListing] {
        (MockData.shared.sampleGigs as? [GigListing]) ?? []
    }
    
    var filteredGigs: [GigListing] {
        if let category = selectedCategory {
            return gigs.filter { $0.category == category }
        }
        return gigs
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        // Header
                        TerminalHeader(title: "Available Gigs")
                        
                        // Category filters
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: Theme.Spacing.sm) {
                                FilterChip(
                                    title: "All",
                                    isSelected: selectedCategory == nil,
                                    action: { selectedCategory = nil }
                                )
                                
                                ForEach(GigCategory.allCases, id: \.self) { category in
                                    FilterChip(
                                        title: category.rawValue,
                                        isSelected: selectedCategory == category,
                                        action: { selectedCategory = category }
                                    )
                                }
                            }
                            .padding(.horizontal, Theme.Spacing.md)
                        }
                        
                        // Results count
                        Text("> \(filteredGigs.count) gig(s) available")
                            .font(Theme.Typography.caption)
                            .foregroundColor(Theme.Colors.textSecondary)
                            .padding(.horizontal, Theme.Spacing.md)
                        
                        // Gigs list
                        if filteredGigs.isEmpty {
                            EmptyStateView(message: "no gigs found in this category_")
                                .padding(.top, Theme.Spacing.xxl)
                        } else {
                            LazyVStack(spacing: Theme.Spacing.md) {
                                ForEach(filteredGigs) { gig in
                                    GigCard(gig: gig, onViewDetails: {
                                        selectedGig = gig
                                    })
                                }
                            }
                            .padding(.horizontal, Theme.Spacing.md)
                        }
                        
                        Spacer(minLength: Theme.Spacing.xl)
                    }
                    .padding(.bottom, Theme.Spacing.md)
                }
            }
            .navigationDestination(item: $selectedGig) { gig in
                GigOfferDetailView(gig: gig)
            }
        }
    }
}

struct GigCard: View {
    let gig: GigListing
    let onViewDetails: () -> Void
    
    // Find freelancer for this gig
    var freelancer: FreelancerProfile? {
        MockData.shared.sampleFreelancers.first { $0.id == gig.freelancerId }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            // Title
            Text(gig.title)
                .font(Theme.Typography.title)
                .foregroundColor(Theme.Colors.textPrimary)
            
            // Freelancer info
            if let freelancer = freelancer {
                HStack(spacing: Theme.Spacing.xs) {
                    Text("by")
                        .font(Theme.Typography.tiny)
                        .foregroundColor(Theme.Colors.textSecondary)
                    Text(freelancer.handle)
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.accent)
                }
            }
            
            // Description
            Text(gig.description)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
                .lineSpacing(4)
                .padding(.top, Theme.Spacing.xs)
            
            // Categories
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Theme.Spacing.xs) {
                    CategoryTag(category: gig.category.rawValue)
                }
            }
            .padding(.top, Theme.Spacing.xs)
            
            // Key details preview (derived from description)
            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                Text("KEY DETAILS:")
                    .font(Theme.Typography.tiny)
                    .foregroundColor(Theme.Colors.textSecondary)

                // Show up to 3 bullet points derived from description sentences
                let bullets = gig.description
                    .split(whereSeparator: { $0 == "." || $0 == "\n" })
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .filter { !$0.isEmpty }
                    .prefix(3)

                ForEach(Array(bullets.enumerated()), id: \.offset) { _, item in
                    HStack(spacing: Theme.Spacing.xs) {
                        Text("•")
                            .foregroundColor(Theme.Colors.accent)
                        Text(item)
                            .font(Theme.Typography.caption)
                            .foregroundColor(Theme.Colors.textPrimary)
                    }
                }
            }
            .padding(.top, Theme.Spacing.sm)
            
            // Pricing and timing
            HStack {
                HStack(spacing: Theme.Spacing.xs) {
                    Image(systemName: "clock")
                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                    Text("\(gig.estimatedHours)h")
                        .font(Theme.Typography.caption)
                }
                .foregroundColor(Theme.Colors.textSecondary)
                
                Spacer()
                
                Text("$\(Int(gig.budget))")
                    .font(Theme.Typography.title)
                    .foregroundColor(Theme.Colors.accent)
            }
            .padding(.top, Theme.Spacing.sm)
            
            // Action button
            TerminalButton("VIEW DETAILS") {
                onViewDetails()
            }
            .padding(.top, Theme.Spacing.xs)
        }
        .padding(Theme.Spacing.md)
        .terminalCard()
    }
}

#Preview {
    GigsView()
}

