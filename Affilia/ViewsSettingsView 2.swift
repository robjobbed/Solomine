//
//  SettingsView.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/14/26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var authManager = AuthenticationManager.shared
    @AppStorage("preferredColorScheme") private var preferredColorScheme: String = "dark"
    @State private var showingAbout = false
    @State private var showingPrivacyPolicy = false
    @State private var showingTermsOfService = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        // Appearance Section
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            SectionHeader("Appearance")
                            
                            VStack(spacing: Theme.Spacing.sm) {
                                // Theme toggle
                                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                                    Text("THEME")
                                        .font(Theme.Typography.caption)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                    
                                    HStack(spacing: Theme.Spacing.sm) {
                                        ThemeOptionButton(
                                            icon: "sun.max.fill",
                                            label: "LIGHT",
                                            isSelected: preferredColorScheme == "light",
                                            action: { preferredColorScheme = "light" }
                                        )
                                        
                                        ThemeOptionButton(
                                            icon: "moon.fill",
                                            label: "DARK",
                                            isSelected: preferredColorScheme == "dark",
                                            action: { preferredColorScheme = "dark" }
                                        )
                                        
                                        ThemeOptionButton(
                                            icon: "gear",
                                            label: "AUTO",
                                            isSelected: preferredColorScheme == "system",
                                            action: { preferredColorScheme = "system" }
                                        )
                                    }
                                }
                                .padding(Theme.Spacing.md)
                                .terminalCard()
                            }
                            .padding(.horizontal, Theme.Spacing.md)
                        }
                        
                        // Account Section
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            SectionHeader("Account")
                            
                            VStack(spacing: Theme.Spacing.sm) {
                                // User info
                                if let user = authManager.currentUser {
                                    VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                                        SettingsRow(
                                            icon: "envelope",
                                            title: "Email",
                                            value: user.email
                                        )
                                        
                                        if let role = user.role {
                                            SettingsRow(
                                                icon: "person.circle",
                                                title: "Role",
                                                value: role.rawValue.capitalized
                                            )
                                        }
                                        
                                        if let xProfile = authManager.xProfile {
                                            SettingsRow(
                                                icon: "bird",
                                                title: "X Account",
                                                value: "@\(xProfile.username)"
                                            )
                                        }
                                        
                                        if let githubProfile = authManager.githubProfile {
                                            SettingsRow(
                                                icon: "chevron.left.forwardslash.chevron.right",
                                                title: "GitHub",
                                                value: "@\(githubProfile.username)"
                                            )
                                        }
                                    }
                                    .padding(Theme.Spacing.md)
                                    .terminalCard()
                                }
                            }
                            .padding(.horizontal, Theme.Spacing.md)
                        }
                        
                        // Support Section
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            SectionHeader("Support & Legal")
                            
                            VStack(spacing: Theme.Spacing.sm) {
                                SettingsButton(
                                    icon: "info.circle",
                                    title: "About Solomine",
                                    action: { showingAbout = true }
                                )
                                
                                SettingsButton(
                                    icon: "envelope.circle",
                                    title: "Contact Support",
                                    action: { sendEmail() }
                                )
                                
                                SettingsButton(
                                    icon: "doc.text",
                                    title: "Privacy Policy",
                                    action: { showingPrivacyPolicy = true }
                                )
                                
                                SettingsButton(
                                    icon: "doc.plaintext",
                                    title: "Terms of Service",
                                    action: { showingTermsOfService = true }
                                )
                            }
                            .padding(.horizontal, Theme.Spacing.md)
                        }
                        
                        // Danger Zone
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            SectionHeader("Danger Zone", color: Theme.Colors.accentSecondary)
                            
                            VStack(spacing: Theme.Spacing.sm) {
                                Button(action: {
                                    authManager.signOut()
                                    dismiss()
                                }) {
                                    HStack {
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                                        Text("LOG OUT")
                                            .font(Theme.Typography.body)
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 12, weight: .regular, design: .monospaced))
                                    }
                                    .foregroundColor(Theme.Colors.accentSecondary)
                                    .padding(Theme.Spacing.md)
                                    .terminalCard()
                                }
                            }
                            .padding(.horizontal, Theme.Spacing.md)
                        }
                        
                        // App Version
                        VStack(spacing: Theme.Spacing.xs) {
                            Text("SOLOMINE v1.0.0")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            Text("Built with ❤️ for solo devs")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, Theme.Spacing.xl)
                        .padding(.bottom, Theme.Spacing.xxl)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Theme.Colors.accent)
                }
            }
            .sheet(isPresented: $showingAbout) {
                AboutView()
            }
            .sheet(isPresented: $showingPrivacyPolicy) {
                PrivacyPolicyView()
            }
            .sheet(isPresented: $showingTermsOfService) {
                TermsOfServiceView()
            }
        }
    }
    
    private func sendEmail() {
        let email = "rob@solomine.io"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Settings Components

struct SectionHeader: View {
    let title: String
    var icon: String? = nil
    var color: Color = Theme.Colors.accent
    
    init(_ title: String, icon: String? = nil, color: Color = Theme.Colors.accent) {
        self.title = title
        self.icon = icon
        self.color = color
    }
    
    var body: some View {
        HStack(spacing: Theme.Spacing.xs) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
            Text(title.uppercased())
                .font(Theme.Typography.caption)
                .kerning(1)
        }
        .foregroundColor(color)
        .padding(.horizontal, Theme.Spacing.md)
        .padding(.top, Theme.Spacing.sm)
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: Theme.Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .foregroundColor(Theme.Colors.accent)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                Text(title.uppercased())
                    .font(Theme.Typography.tiny)
                    .foregroundColor(Theme.Colors.textSecondary)
                
                Text(value)
                    .font(Theme.Typography.caption)
                    .foregroundColor(Theme.Colors.textPrimary)
            }
            
            Spacer()
        }
    }
}

struct SettingsButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundColor(Theme.Colors.accent)
                    .frame(width: 20)
                
                Text(title.uppercased())
                    .font(Theme.Typography.body)
                    .foregroundColor(Theme.Colors.textPrimary)
                
                Spacer()
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundColor(Theme.Colors.accent)
            }
            .padding(Theme.Spacing.md)
            .terminalCard()
        }
    }
}

struct ThemeOptionButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Theme.Spacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.accent)
                
                Text(label)
                    .font(Theme.Typography.tiny)
                    .foregroundColor(isSelected ? Theme.Colors.background : Theme.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Theme.Spacing.sm)
            .background(isSelected ? Theme.Colors.accent : Theme.Colors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                    .stroke(isSelected ? Theme.Colors.accent : Theme.Colors.border, lineWidth: isSelected ? 2 : 1)
            )
            .cornerRadius(Theme.CornerRadius.small)
        }
    }
}

// MARK: - About View

struct AboutView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.xl) {
                        // Logo
                        VStack(spacing: Theme.Spacing.md) {
                            Text("SOLOMINE")
                                .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .foregroundColor(Theme.Colors.accent)
                                .kerning(4)
                            
                            Text("> marketplace for solo devs")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, Theme.Spacing.xl)
                        
                        // Version
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            Text("VERSION")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            Text("1.0.0")
                                .font(Theme.Typography.body)
                                .foregroundColor(Theme.Colors.textPrimary)
                        }
                        .padding(Theme.Spacing.md)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .terminalCard()
                        .padding(.horizontal, Theme.Spacing.md)
                        
                        // Description
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            Text("ABOUT")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            Text("Solomine is a marketplace connecting talented solo developers with clients looking to build amazing products.")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.textPrimary)
                                .lineSpacing(4)
                        }
                        .padding(Theme.Spacing.md)
                        .terminalCard()
                        .padding(.horizontal, Theme.Spacing.md)
                        
                        // Features
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            Text("FEATURES")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                                FeatureBullet("Browse verified developers")
                                FeatureBullet("Post and find gigs")
                                FeatureBullet("Direct messaging")
                                FeatureBullet("Secure payments (coming soon)")
                                FeatureBullet("GitHub integration")
                            }
                        }
                        .padding(Theme.Spacing.md)
                        .terminalCard()
                        .padding(.horizontal, Theme.Spacing.md)
                        
                        // Contact
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            Text("CONTACT")
                                .font(Theme.Typography.tiny)
                                .foregroundColor(Theme.Colors.textSecondary)
                            
                            Text("rob@solomine.io")
                                .font(Theme.Typography.caption)
                                .foregroundColor(Theme.Colors.accent)
                        }
                        .padding(Theme.Spacing.md)
                        .terminalCard()
                        .padding(.horizontal, Theme.Spacing.md)
                        
                        // Credits
                        Text("Built with ❤️ for the solo dev community")
                            .font(Theme.Typography.tiny)
                            .foregroundColor(Theme.Colors.textSecondary)
                            .frame(maxWidth: .infinity)
                            .padding(.top, Theme.Spacing.xl)
                    }
                    .padding(.bottom, Theme.Spacing.xxl)
                }
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Theme.Colors.accent)
                }
            }
        }
    }
}

struct FeatureBullet: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack(spacing: Theme.Spacing.xs) {
            Text(">")
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.accent)
            
            Text(text)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textPrimary)
        }
    }
}

// MARK: - Privacy Policy View

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        Text("PRIVACY POLICY")
                            .font(Theme.Typography.heading)
                            .foregroundColor(Theme.Colors.accent)
                            .padding(.horizontal, Theme.Spacing.md)
                            .padding(.top, Theme.Spacing.md)
                        
                        Text("Last updated: February 14, 2026")
                            .font(Theme.Typography.tiny)
                            .foregroundColor(Theme.Colors.textSecondary)
                            .padding(.horizontal, Theme.Spacing.md)
                        
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            PolicySection(
                                title: "Information We Collect",
                                content: "We collect information you provide when you create an account, including your email, X (Twitter) handle, and GitHub username. We also collect profile information such as skills, bio, and pricing."
                            )
                            
                            PolicySection(
                                title: "How We Use Your Information",
                                content: "We use your information to provide and improve our services, connect you with other users, process transactions, and send you important updates about your account."
                            )
                            
                            PolicySection(
                                title: "Data Security",
                                content: "We implement industry-standard security measures to protect your personal information. Your data is encrypted in transit and at rest."
                            )
                            
                            PolicySection(
                                title: "Third-Party Services",
                                content: "We use X (Twitter) and GitHub for authentication. Please review their privacy policies for information on how they handle your data."
                            )
                            
                            PolicySection(
                                title: "Your Rights",
                                content: "You have the right to access, update, or delete your personal information. Contact us at rob@solomine.io to exercise these rights."
                            )
                            
                            PolicySection(
                                title: "Contact Us",
                                content: "If you have questions about this Privacy Policy, contact us at rob@solomine.io"
                            )
                        }
                        .padding(.horizontal, Theme.Spacing.md)
                    }
                    .padding(.bottom, Theme.Spacing.xxl)
                }
            }
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Theme.Colors.accent)
                }
            }
        }
    }
}

// MARK: - Terms of Service View

struct TermsOfServiceView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        Text("TERMS OF SERVICE")
                            .font(Theme.Typography.heading)
                            .foregroundColor(Theme.Colors.accent)
                            .padding(.horizontal, Theme.Spacing.md)
                            .padding(.top, Theme.Spacing.md)
                        
                        Text("Last updated: February 14, 2026")
                            .font(Theme.Typography.tiny)
                            .foregroundColor(Theme.Colors.textSecondary)
                            .padding(.horizontal, Theme.Spacing.md)
                        
                        VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                            PolicySection(
                                title: "Acceptance of Terms",
                                content: "By using Solomine, you agree to these Terms of Service. If you don't agree, please don't use our service."
                            )
                            
                            PolicySection(
                                title: "User Accounts",
                                content: "You are responsible for maintaining the security of your account. You must provide accurate information and keep it updated."
                            )
                            
                            PolicySection(
                                title: "User Conduct",
                                content: "You agree to use Solomine professionally and respectfully. Harassment, spam, or illegal activity is prohibited and may result in account termination."
                            )
                            
                            PolicySection(
                                title: "Content",
                                content: "You retain ownership of content you post, but grant Solomine a license to display and distribute it on our platform."
                            )
                            
                            PolicySection(
                                title: "Payments",
                                content: "All transactions are subject to our payment terms. Solomine may take a service fee from transactions processed through the platform."
                            )
                            
                            PolicySection(
                                title: "Termination",
                                content: "We reserve the right to suspend or terminate accounts that violate these terms or for any other reason at our discretion."
                            )
                            
                            PolicySection(
                                title: "Limitation of Liability",
                                content: "Solomine is provided 'as is' without warranties. We are not liable for any damages arising from your use of the service."
                            )
                            
                            PolicySection(
                                title: "Contact",
                                content: "Questions about these terms? Contact us at rob@solomine.io"
                            )
                        }
                        .padding(.horizontal, Theme.Spacing.md)
                    }
                    .padding(.bottom, Theme.Spacing.xxl)
                }
            }
            .navigationTitle("Terms of Service")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Theme.Colors.accent)
                }
            }
        }
    }
}

struct PolicySection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
            Text(title.uppercased())
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.accent)
            
            Text(content)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textPrimary)
                .lineSpacing(4)
        }
        .padding(Theme.Spacing.md)
        .terminalCard()
    }
}

#Preview("Settings") {
    SettingsView()
}

#Preview("About") {
    AboutView()
}

#Preview("Privacy") {
    PrivacyPolicyView()
}

#Preview("Terms") {
    TermsOfServiceView()
}
