//
//  EditProfileView.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/14/26.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var authManager = AuthenticationManager.shared
    
    // Form fields
    @State private var displayName: String = ""
    @State private var bio: String = ""
    @State private var skills: [String] = []
    @State private var newSkill: String = ""
    @State private var hourlyRate: String = ""
    @State private var projectRate: String = ""
    @State private var availability: AvailabilityStatus = .available
    
    // UI state
    @State private var showingSkillInput = false
    @State private var isSaving = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        // Avatar section
                        VStack(spacing: Theme.Spacing.md) {
                            AvatarView(displayName: displayName.isEmpty ? "?" : displayName, size: 80)
                            
                            Button(action: {}) {
                                HStack(spacing: Theme.Spacing.xs) {
                                    Image(systemName: "camera")
                                        .font(.system(size: 12, weight: .regular, design: .monospaced))
                                    Text("CHANGE PHOTO")
                                        .font(Theme.Typography.tiny)
                                }
                                .foregroundColor(Theme.Colors.accent)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, Theme.Spacing.md)
                        
                        // Basic Info
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            SectionHeader("Basic Info")
                            
                            VStack(spacing: Theme.Spacing.md) {
                                // Display Name
                                FormField(
                                    label: "DISPLAY NAME",
                                    text: $displayName,
                                    placeholder: "Enter your name"
                                )
                                
                                // Bio
                                FormTextEditor(
                                    label: "BIO",
                                    text: $bio,
                                    placeholder: "Tell clients about yourself..."
                                )
                            }
                            .padding(.horizontal, Theme.Spacing.md)
                        }
                        
                        // Skills
                        if authManager.currentUser?.role == .builder {
                            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                                SectionHeader("Skills")
                                
                                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                                    // Skills list
                                    if skills.isEmpty {
                                        Text("> no skills added yet")
                                            .font(Theme.Typography.caption)
                                            .foregroundColor(Theme.Colors.textSecondary)
                                            .padding(Theme.Spacing.md)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .terminalCard()
                                    } else {
                                        FlowLayout(spacing: Theme.Spacing.xs) {
                                            ForEach(skills, id: \.self) { skill in
                                                SkillChip(skill: skill) {
                                                    removeSkill(skill)
                                                }
                                            }
                                        }
                                    }
                                    
                                    // Add skill button
                                    if showingSkillInput {
                                        HStack(spacing: Theme.Spacing.sm) {
                                            TextField("", text: $newSkill, prompt: Text("Enter skill").foregroundColor(Theme.Colors.textSecondary))
                                                .font(Theme.Typography.body)
                                                .foregroundColor(Theme.Colors.textPrimary)
                                                .padding(Theme.Spacing.sm)
                                                .background(Theme.Colors.surface)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                                        .stroke(Theme.Colors.border, lineWidth: Theme.BorderWidth.thin)
                                                )
                                                .cornerRadius(Theme.CornerRadius.small)
                                            
                                            Button(action: addSkill) {
                                                Image(systemName: "checkmark")
                                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                                    .foregroundColor(Theme.Colors.background)
                                                    .frame(width: 36, height: 36)
                                                    .background(Theme.Colors.accent)
                                                    .cornerRadius(Theme.CornerRadius.small)
                                            }
                                            
                                            Button(action: { showingSkillInput = false; newSkill = "" }) {
                                                Image(systemName: "xmark")
                                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                                    .foregroundColor(Theme.Colors.accent)
                                                    .frame(width: 36, height: 36)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                                                            .stroke(Theme.Colors.accent, lineWidth: Theme.BorderWidth.thin)
                                                    )
                                                    .cornerRadius(Theme.CornerRadius.small)
                                            }
                                        }
                                    } else {
                                        Button(action: { showingSkillInput = true }) {
                                            HStack {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                                Text("ADD SKILL")
                                                    .font(Theme.Typography.body)
                                            }
                                            .foregroundColor(Theme.Colors.accent)
                                            .padding(Theme.Spacing.sm)
                                            .frame(maxWidth: .infinity)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                                                    .stroke(Theme.Colors.accent, lineWidth: Theme.BorderWidth.thin)
                                            )
                                            .cornerRadius(Theme.CornerRadius.medium)
                                        }
                                    }
                                }
                                .padding(.horizontal, Theme.Spacing.md)
                            }
                            
                            // Pricing
                            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                                SectionHeader("Pricing")
                                
                                VStack(spacing: Theme.Spacing.md) {
                                    FormField(
                                        label: "HOURLY RATE ($)",
                                        text: $hourlyRate,
                                        placeholder: "0",
                                        keyboardType: .numberPad
                                    )
                                    
                                    Text("OR")
                                        .font(Theme.Typography.tiny)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                        .frame(maxWidth: .infinity)
                                    
                                    FormField(
                                        label: "PROJECT RATE ($)",
                                        text: $projectRate,
                                        placeholder: "0",
                                        keyboardType: .numberPad
                                    )
                                }
                                .padding(.horizontal, Theme.Spacing.md)
                            }
                            
                            // Availability
                            VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                                SectionHeader("Availability")
                                
                                VStack(spacing: Theme.Spacing.sm) {
                                    ForEach(AvailabilityStatus.allCases, id: \.self) { status in
                                        AvailabilityOption(
                                            status: status,
                                            isSelected: availability == status,
                                            action: { availability = status }
                                        )
                                    }
                                }
                                .padding(.horizontal, Theme.Spacing.md)
                            }
                        }
                        
                        Spacer(minLength: Theme.Spacing.xxl)
                    }
                    .padding(.bottom, Theme.Spacing.xxl)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Theme.Colors.textSecondary)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: saveProfile) {
                        if isSaving {
                            ProgressView()
                                .tint(Theme.Colors.accent)
                        } else {
                            Text("Save")
                                .foregroundColor(Theme.Colors.accent)
                                .fontWeight(.semibold)
                        }
                    }
                    .disabled(isSaving)
                }
            }
            .onAppear {
                loadCurrentProfile()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func loadCurrentProfile() {
        guard let user = authManager.currentUser,
              let profile = user.freelancerProfile else { return }
        
        displayName = profile.displayName
        bio = profile.bio
        skills = profile.skills
        
        if let rate = profile.hourlyRate {
            hourlyRate = String(format: "%.0f", rate)
        }
        if let project = profile.projectBasedPricing {
            projectRate = String(format: "%.0f", project)
        }
        
        availability = profile.availability
    }
    
    private func addSkill() {
        let trimmed = newSkill.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !skills.contains(trimmed) else { return }
        
        skills.append(trimmed)
        newSkill = ""
        showingSkillInput = false
    }
    
    private func removeSkill(_ skill: String) {
        skills.removeAll { $0 == skill }
    }
    
    private func saveProfile() {
        isSaving = true
        
        // Simulate save delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // In production, this would save to backend
            // For now, just update local state
            
            // TODO: Update authManager.currentUser with new profile data
            
            isSaving = false
            dismiss()
        }
    }
}

// MARK: - Form Components

struct FormField: View {
    let label: String
    @Binding var text: String
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
            Text(label)
                .font(Theme.Typography.tiny)
                .foregroundColor(Theme.Colors.textSecondary)
            
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(Theme.Colors.textSecondary))
                .font(Theme.Typography.body)
                .foregroundColor(Theme.Colors.textPrimary)
                .padding(Theme.Spacing.sm)
                .background(Theme.Colors.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                        .stroke(Theme.Colors.border, lineWidth: Theme.BorderWidth.thin)
                )
                .cornerRadius(Theme.CornerRadius.medium)
                .keyboardType(keyboardType)
        }
    }
}

struct FormTextEditor: View {
    let label: String
    @Binding var text: String
    var placeholder: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
            Text(label)
                .font(Theme.Typography.tiny)
                .foregroundColor(Theme.Colors.textSecondary)
            
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .padding(Theme.Spacing.sm)
                        .padding(.top, 8)
                }
                
                TextEditor(text: $text)
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textPrimary)
                    .padding(Theme.Spacing.sm)
                    .frame(minHeight: 100)
                    .scrollContentBackground(.hidden)
                    .background(Theme.Colors.surface)
            }
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                    .stroke(Theme.Colors.border, lineWidth: Theme.BorderWidth.thin)
            )
            .cornerRadius(Theme.CornerRadius.medium)
        }
    }
}

struct SkillChip: View {
    let skill: String
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: Theme.Spacing.xs) {
            Text(skill)
                .font(Theme.Typography.tiny)
                .foregroundColor(Theme.Colors.textPrimary)
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                    .foregroundColor(Theme.Colors.accent)
            }
        }
        .padding(.horizontal, Theme.Spacing.sm)
        .padding(.vertical, Theme.Spacing.xs)
        .background(Theme.Colors.surface)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                .stroke(Theme.Colors.accent, lineWidth: Theme.BorderWidth.thin)
        )
        .cornerRadius(Theme.CornerRadius.small)
    }
}

struct AvailabilityOption: View {
    let status: AvailabilityStatus
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    HStack(spacing: Theme.Spacing.xs) {
                        Circle()
                            .fill(statusColor)
                            .frame(width: 8, height: 8)
                        
                        Text(status.rawValue.uppercased())
                            .font(Theme.Typography.body)
                            .foregroundColor(Theme.Colors.textPrimary)
                    }
                    
                    Text(statusDescription)
                        .font(Theme.Typography.tiny)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 20, weight: .regular, design: .monospaced))
                    .foregroundColor(isSelected ? Theme.Colors.accent : Theme.Colors.border)
            }
            .padding(Theme.Spacing.md)
            .background(isSelected ? Theme.Colors.surface : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                    .stroke(isSelected ? Theme.Colors.accent : Theme.Colors.border, lineWidth: isSelected ? 2 : 1)
            )
            .cornerRadius(Theme.CornerRadius.medium)
        }
    }
    
    var statusColor: Color {
        switch status {
        case .available: return .green
        case .busy: return .orange
        case .unavailable: return .red
        }
    }
    
    var statusDescription: String {
        switch status {
        case .available: return "Ready for new projects"
        case .busy: return "Limited availability"
        case .unavailable: return "Not taking new work"
        }
    }
}

// MARK: - Flow Layout for Skills

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x, y: bounds.minY + result.positions[index].y), proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize = .zero
        var positions: [CGPoint] = []
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var lineHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if x + size.width > maxWidth && x > 0 {
                    x = 0
                    y += lineHeight + spacing
                    lineHeight = 0
                }
                
                positions.append(CGPoint(x: x, y: y))
                lineHeight = max(lineHeight, size.height)
                x += size.width + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: y + lineHeight)
        }
    }
}

#Preview {
    EditProfileView()
}
