//
//  GigDetailView.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/3/26.
//

import SwiftUI

struct GigDetailView: View {
    let gig: GigListing
    @State private var showingBookingSheet = false
    @Environment(\.dismiss) private var dismiss
    
    // Find freelancer for this gig
    var freelancer: FreelancerProfile? {
        MockData.shared.sampleFreelancers.first { $0.id == gig.freelancerId }
    }
    
    var body: some View {
        ZStack {
            Theme.Colors.background.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                    // Header with back button
                    HStack {
                        Button(action: { dismiss() }) {
                            HStack(spacing: Theme.Spacing.xs) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                Text("BACK")
                                    .font(Theme.Typography.caption)
                            }
                            .foregroundColor(Theme.Colors.accent)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, Theme.Spacing.md)
                    .padding(.top, Theme.Spacing.sm)
                    
                    // Gig title and freelancer
                    VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                        Text(gig.title)
                            .font(Theme.Typography.headingLarge)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        // Freelancer info
                        if let freelancer = freelancer {
                            HStack(spacing: Theme.Spacing.sm) {
                                AvatarView(displayName: freelancer.displayName, size: 40)
                                
                                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                                    Text(freelancer.displayName)
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                    
                                    HStack(spacing: Theme.Spacing.xs) {
                                        Image(systemName: "bird.fill")
                                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                                        Text(freelancer.handle)
                                    }
                                    .font(Theme.Typography.caption)
                                    .foregroundColor(Theme.Colors.accent)
                                }
                                
                                Spacer()
                                
                                // Rating badge
                                HStack(spacing: Theme.Spacing.xs) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                                    Text(String(format: "%.1f", freelancer.averageRating))
                                        .font(Theme.Typography.caption)
                                }
                                .foregroundColor(Theme.Colors.accent)
                            }
                        }
                    }
                    .padding(Theme.Spacing.md)
                    .terminalCard()
                    .padding(.horizontal, Theme.Spacing.md)
                    
                    // Pricing and timing stats
                    HStack(spacing: Theme.Spacing.md) {
                        StatColumn(label: "PRICE", value: "$\(Int(gig.budget))")
                        Divider()
                            .background(Theme.Colors.border)
                            .frame(height: 40)
                        StatColumn(label: "TURNAROUND", value: "\(gig.estimatedHours)h")
                        Divider()
                            .background(Theme.Colors.border)
                            .frame(height: 40)
                        StatColumn(label: "POSTED", value: gig.postedDate.formatted(.relative(presentation: .named)))
                    }
                    .padding(Theme.Spacing.md)
                    .terminalCard()
                    .padding(.horizontal, Theme.Spacing.md)
                    
                    // Description section
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        SectionHeader("Description")
                        
                        Text(gig.description)
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textPrimary)
                            .lineSpacing(6)
                            .padding(.horizontal, Theme.Spacing.md)
                    }
                    
                    // Categories section
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        SectionHeader("Categories")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: Theme.Spacing.xs) {
                                CategoryTag(category: gig.category.rawValue)
                            }
                            .padding(.horizontal, Theme.Spacing.md)
                        }
                    }
                    
                    // Deliverables section
                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                        SectionHeader("What You'll Get")
                        
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            ForEach(gig.requirements, id: \.self) { deliverable in
                                HStack(alignment: .top, spacing: Theme.Spacing.sm) {
                                    Text("•")
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.accent)
                                    Text(deliverable)
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                    Spacer()
                                }
                            }
                        }
                        .padding(Theme.Spacing.md)
                        .terminalCard()
                        .padding(.horizontal, Theme.Spacing.md)
                    }
                    
                    // Action button
                    VStack(spacing: Theme.Spacing.sm) {
                        TerminalButton("BOOK THIS GIG") {
                            showingBookingSheet = true
                        }
                        
                        if let freelancer = freelancer {
                            Button(action: {
                                // Navigate to freelancer profile
                            }) {
                                HStack(spacing: Theme.Spacing.xs) {
                                    Text("VIEW")
                                    Text(freelancer.handle.uppercased())
                                        .foregroundColor(Theme.Colors.accent)
                                    Text("PROFILE")
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                                }
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textPrimary)
                            }
                        }
                    }
                    .padding(.horizontal, Theme.Spacing.md)
                    .padding(.bottom, Theme.Spacing.xl)
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showingBookingSheet) {
            BookingSheetView(gig: gig, freelancer: freelancer)
        }
    }
}

// MARK: - Booking Sheet
struct BookingSheetView: View {
    let gig: GigListing
    let freelancer: FreelancerProfile?
    @Environment(\.dismiss) private var dismiss
    @State private var projectDetails = ""
    @State private var deadline: Date = Date().addingTimeInterval(7 * 24 * 60 * 60) // 7 days from now
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        // Summary
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            SectionHeader("Gig Summary")
                            
                            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                                Text(gig.title)
                                    .font(Theme.Typography.title)
                                    .foregroundColor(Theme.Colors.textPrimary)
                                
                                if let freelancer = freelancer {
                                    Text("with \(freelancer.displayName)")
                                        .font(Theme.Typography.caption)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                }
                                
                                HStack {
                                    Text("$\(Int(gig.budget))")
                                        .font(Theme.Typography.title)
                                        .foregroundColor(Theme.Colors.accent)
                                    
                                    Spacer()
                                    
                                    Text("~\(gig.estimatedHours) days")
                                        .font(Theme.Typography.caption)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                }
                                .padding(.top, Theme.Spacing.xs)
                            }
                            .padding(Theme.Spacing.md)
                            .terminalCard()
                        }
                        
                        // Project details input
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            SectionHeader("Project Details")
                            
                            Text("Tell \(freelancer?.displayName ?? "the freelancer") about your project:")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            TextEditor(text: $projectDetails)
                                .font(Theme.Typography.body)
                                .foregroundColor(Theme.Colors.textPrimary)
                                .scrollContentBackground(.hidden)
                                .background(Theme.Colors.surface)
                                .frame(height: 150)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Theme.Colors.border, lineWidth: 1)
                                )
                            
                            if projectDetails.isEmpty {
                                Text("Include requirements, deadlines, and any specific details...")
                                    .font(Theme.Typography.tiny)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                    .padding(.top, -140)
                                    .padding(.leading, Theme.Spacing.sm)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                        // Deadline picker
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            SectionHeader("Preferred Deadline")
                            
                            DatePicker(
                                "Deadline",
                                selection: $deadline,
                                in: Date()...,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.graphical)
                            .tint(Theme.Colors.accent)
                        }
                        
                        // Action buttons
                        VStack(spacing: Theme.Spacing.sm) {
                            TerminalButton("SEND BOOKING REQUEST") {
                                // Handle booking submission
                                dismiss()
                            }
                            
                            Button("Cancel") {
                                dismiss()
                            }
                            .font(Theme.Typography.caption)
                            .foregroundColor(Theme.Colors.textSecondary)
                        }
                        .padding(.top, Theme.Spacing.md)
                    }
                    .padding(Theme.Spacing.md)
                }
            }
            .navigationTitle("Book Gig")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.accent)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    GigDetailView(gig: GigListing(
        id: UUID(),
        hirerId: UUID(),
        hirerName: "Preview User",
        hirerHandle: "@preview",
        title: "Preview Gig",
        description: "This is a preview gig for testing the detail view.",
        requirements: ["SwiftUI", "Combine"],
        budget: 999,
        estimatedHours: 6,
        category: .mobileDev,
        urgency: .normal,
        postedDate: Date().addingTimeInterval(-600),
        applicants: 1
    ))
}

