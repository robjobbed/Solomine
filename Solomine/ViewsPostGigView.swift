//
//  PostGigView.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/4/26.
//

import SwiftUI

/// View for hirers to post new gig listings
struct PostGigView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var gigManager = GigManager.shared
    
    @State private var title = ""
    @State private var description = ""
    @State private var requirements: [String] = [""]
    @State private var budget = ""
    @State private var estimatedHours = ""
    @State private var selectedCategory: GigCategory = .webDev
    @State private var selectedUrgency: GigUrgency = .normal
    @State private var showingSuccessAlert = false
    
    var isFormValid: Bool {
        !title.isEmpty &&
        !description.isEmpty &&
        !budget.isEmpty &&
        !estimatedHours.isEmpty &&
        requirements.contains(where: { !$0.isEmpty })
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        // Header
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text("POST A GIG")
                                .font(Theme.Typography.h1)
                                .foregroundColor(Theme.Colors.accent)
                            
                            Text("Find the perfect builder for your project")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                        }
                        
                        Divider()
                            .background(Theme.Colors.border)
                        
                        // Title
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text("GIG TITLE *")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            TextField("", text: $title, prompt: Text("e.g., SwiftUI Dashboard Design").foregroundColor(Theme.Colors.textSecondary))
                                .font(Theme.Typography.body)
                                .foregroundColor(Theme.Colors.textPrimary)
                                .padding(Theme.Spacing.sm)
                                .background(Theme.Colors.surface)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                        .stroke(Theme.Colors.border, lineWidth: Theme.BorderWidth.thin)
                                )
                                .cornerRadius(Theme.CornerRadius.small)
                        }
                        
                        // Category
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text("CATEGORY *")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: Theme.Spacing.sm) {
                                    ForEach(GigCategory.allCases, id: \.self) { category in
                                        Button {
                                            selectedCategory = category
                                        } label: {
                                            Text(category.rawValue)
                                                .font(Theme.Typography.tiny)
                                                .foregroundColor(selectedCategory == category ? Theme.Colors.background : Theme.Colors.accent)
                                                .padding(.horizontal, Theme.Spacing.sm)
                                                .padding(.vertical, Theme.Spacing.xs)
                                                .background(selectedCategory == category ? Theme.Colors.accent : Color.clear)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                                        .stroke(Theme.Colors.accent, lineWidth: Theme.BorderWidth.thin)
                                                )
                                                .cornerRadius(Theme.CornerRadius.small)
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text("DESCRIPTION *")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            TextEditor(text: $description)
                                .font(Theme.Typography.body)
                                .foregroundColor(Theme.Colors.textPrimary)
                                .frame(minHeight: 100)
                                .padding(Theme.Spacing.sm)
                                .background(Theme.Colors.surface)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                        .stroke(Theme.Colors.border, lineWidth: Theme.BorderWidth.thin)
                                )
                                .cornerRadius(Theme.CornerRadius.small)
                            
                            if description.isEmpty {
                                Text("> Describe your project in detail_")
                                    .font(Theme.Typography.caption)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                    .padding(.horizontal, Theme.Spacing.sm)
                                    .offset(y: -90)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                        // Requirements
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            Text("REQUIREMENTS *")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            ForEach(requirements.indices, id: \.self) { index in
                                HStack(spacing: Theme.Spacing.sm) {
                                    TextField("", text: $requirements[index], prompt: Text("e.g., SwiftUI experience").foregroundColor(Theme.Colors.textSecondary))
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                        .padding(Theme.Spacing.sm)
                                        .background(Theme.Colors.surface)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                                .stroke(Theme.Colors.border, lineWidth: Theme.BorderWidth.thin)
                                        )
                                        .cornerRadius(Theme.CornerRadius.small)
                                    
                                    if requirements.count > 1 {
                                        Button {
                                            requirements.remove(at: index)
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(Theme.Colors.textSecondary)
                                        }
                                    }
                                }
                            }
                            
                            Button {
                                requirements.append("")
                            } label: {
                                HStack(spacing: Theme.Spacing.xs) {
                                    Image(systemName: "plus.circle")
                                    Text("Add requirement")
                                }
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.accent)
                            }
                        }
                        
                        // Budget and Time
                        HStack(spacing: Theme.Spacing.md) {
                            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                                Text("BUDGET *")
                                    .font(Theme.Typography.tiny)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                
                                HStack {
                                    Text("$")
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.accent)
                                    
                                    TextField("", text: $budget, prompt: Text("1000").foregroundColor(Theme.Colors.textSecondary))
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                        .keyboardType(.numberPad)
                                }
                                .padding(Theme.Spacing.sm)
                                .background(Theme.Colors.surface)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                        .stroke(Theme.Colors.border, lineWidth: Theme.BorderWidth.thin)
                                )
                                .cornerRadius(Theme.CornerRadius.small)
                            }
                            
                            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                                Text("EST. TIME *")
                                    .font(Theme.Typography.tiny)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                
                                HStack {
                                    TextField("", text: $estimatedHours, prompt: Text("10").foregroundColor(Theme.Colors.textSecondary))
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                        .keyboardType(.numberPad)
                                    
                                    Text("hrs")
                                        .font(Theme.Typography.body)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                }
                                .padding(Theme.Spacing.sm)
                                .background(Theme.Colors.surface)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                        .stroke(Theme.Colors.border, lineWidth: Theme.BorderWidth.thin)
                                )
                                .cornerRadius(Theme.CornerRadius.small)
                            }
                        }
                        
                        // Urgency
                        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                            Text("URGENCY")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            HStack(spacing: Theme.Spacing.sm) {
                                ForEach(GigUrgency.allCases, id: \.self) { urgency in
                                    Button {
                                        selectedUrgency = urgency
                                    } label: {
                                        Text(urgency.rawValue)
                                            .font(Theme.Typography.tiny)
                                            .foregroundColor(selectedUrgency == urgency ? Theme.Colors.background : Theme.Colors.accent)
                                            .padding(.horizontal, Theme.Spacing.sm)
                                            .padding(.vertical, Theme.Spacing.xs)
                                            .background(selectedUrgency == urgency ? Theme.Colors.accent : Color.clear)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                                    .stroke(Theme.Colors.accent, lineWidth: Theme.BorderWidth.thin)
                                            )
                                            .cornerRadius(Theme.CornerRadius.small)
                                    }
                                }
                            }
                        }
                        
                        Divider()
                            .background(Theme.Colors.border)
                        
                        // Post Button
                        Button {
                            postGig()
                        } label: {
                            HStack {
                                Image(systemName: "paperplane.fill")
                                Text("POST GIG")
                            }
                            .font(Theme.Typography.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(Theme.Spacing.md)
                            .background(Theme.Colors.accent)
                            .cornerRadius(Theme.CornerRadius.medium)
                        }
                        .disabled(!isFormValid)
                        .opacity(isFormValid ? 1.0 : 0.5)
                        
                        Spacer(minLength: Theme.Spacing.xl)
                    }
                    .padding(Theme.Spacing.md)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Theme.Colors.accent)
                }
            }
            .alert("Gig Posted!", isPresented: $showingSuccessAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Your gig is now live! Builders will start applying soon.")
            }
        }
    }
    
    private func postGig() {
        guard let budgetValue = Double(budget),
              let hoursValue = Int(estimatedHours) else {
            return
        }
        
        let newGig = GigListing(
            id: UUID(),
            hirerId: UUID(), // In production, use actual user ID
            hirerName: "You", // In production, use actual user name
            hirerHandle: "@yourhandle", // In production, use actual handle
            title: title,
            description: description,
            requirements: requirements.filter { !$0.isEmpty },
            budget: budgetValue,
            estimatedHours: hoursValue,
            category: selectedCategory,
            urgency: selectedUrgency,
            postedDate: Date(),
            applicants: 0
        )
        
        gigManager.postGig(newGig)
        showingSuccessAlert = true
    }
}

// MARK: - Preview

#Preview {
    PostGigView()
}
