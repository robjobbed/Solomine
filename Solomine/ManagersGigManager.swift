//
//  GigManager.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/4/26.
//

import Foundation
internal import Combine

/// Manages gig listings and real-time updates
@MainActor
class GigManager: ObservableObject {
    
    static let shared = GigManager()
    
    @Published var availableGigs: [GigListing] = []
    @Published var myPostedGigs: [GigListing] = []
    @Published var isLoading = false
    
    private var refreshTimer: Timer?
    
    private init() {
        loadMockGigs()
        startAutoRefresh()
    }
    
    // MARK: - Public Methods
    
    func loadGigs() {
        isLoading = true
        
        // In production, fetch from backend
        // For now, simulate network delay
        Task {
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
            loadMockGigs()
            isLoading = false
        }
    }
    
    func postGig(_ gig: GigListing) {
        availableGigs.insert(gig, at: 0)
        myPostedGigs.insert(gig, at: 0)
    }
    
    func removeGig(_ gigId: UUID) {
        availableGigs.removeAll { $0.id == gigId }
        myPostedGigs.removeAll { $0.id == gigId }
    }
    
    // MARK: - Auto Refresh
    
    private func startAutoRefresh() {
        // Simulate new gigs appearing every 15-30 seconds for lively marketplace
        refreshTimer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 15...30), repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.simulateNewGig()
            }
        }
    }
    
    private func simulateNewGig() {
        // Add a random new gig to make marketplace feel alive
        let newGig = generateRandomGig()
        availableGigs.insert(newGig, at: 0)
        
        // Keep only recent 50 gigs
        if availableGigs.count > 50 {
            availableGigs = Array(availableGigs.prefix(50))
        }
    }
    
    // MARK: - Mock Data
    
    private func loadMockGigs() {
        availableGigs = [
            GigListing(
                id: UUID(),
                hirerId: UUID(),
                hirerName: "Sarah Chen",
                hirerHandle: "@sarahbuilds",
                freelancerId: nil,
                title: "SwiftUI App Dashboard - 3 Screens",
                description: "Need a clean, modern dashboard for fitness tracking app. Must have charts, user profile, and settings. Looking for terminal/cyberpunk aesthetic.",
                requirements: ["SwiftUI experience", "Charts framework", "iOS 17+"],
                budget: 1200,
                estimatedHours: 8,
                category: .mobileDev,
                urgency: .urgent,
                postedDate: Date().addingTimeInterval(-300), // 5 min ago
                applicants: 2
            ),
            GigListing(
                id: UUID(),
                hirerId: UUID(),
                hirerName: "Alex Morgan",
                hirerHandle: "@alexdev",
                freelancerId: nil,
                title: "Python Script for Data Scraping",
                description: "Build a web scraper to extract product data from e-commerce sites. Need it to handle pagination and export to CSV.",
                requirements: ["Python", "BeautifulSoup/Scrapy", "Error handling"],
                budget: 400,
                estimatedHours: 4,
                category: .automation,
                urgency: .normal,
                postedDate: Date().addingTimeInterval(-1800), // 30 min ago
                applicants: 5
            ),
            GigListing(
                id: UUID(),
                hirerId: UUID(),
                hirerName: "Marcus Webb",
                hirerHandle: "@marcustech",
                freelancerId: nil,
                title: "REST API for Social Media App",
                description: "Build Node.js backend with Express. Need user auth, post CRUD, and real-time notifications. MongoDB preferred.",
                requirements: ["Node.js", "Express", "MongoDB", "JWT auth", "Socket.io"],
                budget: 2500,
                estimatedHours: 20,
                category: .apiBackend,
                urgency: .normal,
                postedDate: Date().addingTimeInterval(-3600), // 1 hour ago
                applicants: 8
            ),
            GigListing(
                id: UUID(),
                hirerId: UUID(),
                hirerName: "Nina Patel",
                hirerHandle: "@ninadesign",
                freelancerId: nil,
                title: "Figma to SwiftUI Conversion",
                description: "Have a complete Figma design for iOS app (15 screens). Need pixel-perfect SwiftUI implementation with animations.",
                requirements: ["SwiftUI", "Figma", "Animation", "Attention to detail"],
                budget: 3500,
                estimatedHours: 25,
                category: .mobileDev,
                urgency: .urgent,
                postedDate: Date().addingTimeInterval(-7200), // 2 hours ago
                applicants: 12
            ),
            GigListing(
                id: UUID(),
                hirerId: UUID(),
                hirerName: "Dev Sharma",
                hirerHandle: "@devsharma",
                freelancerId: nil,
                title: "AI Chatbot Integration (OpenAI)",
                description: "Integrate GPT-4 into existing web app. Need conversation history, streaming responses, and context management.",
                requirements: ["OpenAI API", "React/Vue", "Backend integration"],
                budget: 1800,
                estimatedHours: 12,
                category: .aiML,
                urgency: .normal,
                postedDate: Date().addingTimeInterval(-10800), // 3 hours ago
                applicants: 15
            ),
            GigListing(
                id: UUID(),
                hirerId: UUID(),
                hirerName: "Jamie Liu",
                hirerHandle: "@jamiecodes",
                freelancerId: nil,
                title: "Quick Bug Fix - React Native App",
                description: "App crashes on Android when uploading images. Need someone to debug and fix ASAP. Should be quick for experienced dev.",
                requirements: ["React Native", "Android", "Debugging"],
                budget: 300,
                estimatedHours: 2,
                category: .mobileDev,
                urgency: .urgent,
                postedDate: Date().addingTimeInterval(-14400), // 4 hours ago
                applicants: 3
            ),
            GigListing(
                id: UUID(),
                hirerId: UUID(),
                hirerName: "Taylor Brooks",
                hirerHandle: "@taylorbuilds",
                freelancerId: nil,
                title: "Vibe Coding Session - Build Landing Page",
                description: "Let's build a sick landing page together. I have designs, you bring the code vibes. Live session on Discord, chill music, get it done.",
                requirements: ["HTML/CSS/JS", "Good vibes", "React nice to have"],
                budget: 500,
                estimatedHours: 4,
                category: .vibeCoding,
                urgency: .normal,
                postedDate: Date().addingTimeInterval(-18000), // 5 hours ago
                applicants: 7
            ),
            GigListing(
                id: UUID(),
                hirerId: UUID(),
                hirerName: "Chris Anderson",
                hirerHandle: "@chrisdev",
                freelancerId: nil,
                title: "WordPress Plugin Development",
                description: "Need custom plugin for appointment booking. Calendar integration, email notifications, payment with Stripe.",
                requirements: ["WordPress", "PHP", "MySQL", "Stripe API"],
                budget: 2000,
                estimatedHours: 15,
                category: .webDev,
                urgency: .normal,
                postedDate: Date().addingTimeInterval(-21600), // 6 hours ago
                applicants: 6
            )
        ]
    }
    
    private func generateRandomGig() -> GigListing {
        let titles = [
            "Quick API Integration Needed",
            "iOS Widget Development",
            "Database Schema Design",
            "Chrome Extension Build",
            "Discord Bot Features",
            "Shopify Theme Customization",
            "Next.js Landing Page",
            "Firebase Setup & Auth",
            "UI Components Package",
            "Payment Gateway Integration"
        ]
        
        let names = ["Jordan", "Taylor", "Casey", "Morgan", "Riley", "Avery", "Quinn", "Sage"]
        let surnames = ["Smith", "Chen", "Kumar", "Garcia", "Lee", "Brown", "Wilson", "Martinez"]
        
        let name = "\(names.randomElement()!) \(surnames.randomElement()!)"
        let handle = "@\(name.lowercased().replacingOccurrences(of: " ", with: ""))"
        
        return GigListing(
            id: UUID(),
            hirerId: UUID(),
            hirerName: name,
            hirerHandle: handle,
            freelancerId: nil,
            title: titles.randomElement()!,
            description: "Looking for experienced developer to help with this project. Details in requirements.",
            requirements: ["Experience required", "Good communication"],
            budget: Double([500, 800, 1200, 1500, 2000].randomElement()!),
            estimatedHours: [4, 6, 8, 10, 12].randomElement()!,
            category: GigCategory.allCases.randomElement()!,
            urgency: [.urgent, .normal, .flexible].randomElement()!,
            postedDate: Date(),
            applicants: Int.random(in: 0...3)
        )
    }
    
    deinit {
        refreshTimer?.invalidate()
    }
}

// MARK: - Gig Listing Model

struct GigListing: Identifiable, Codable, Hashable {
    let id: UUID
    let hirerId: UUID
    let hirerName: String
    let hirerHandle: String
    var freelancerId: UUID?
    var title: String
    var description: String
    var requirements: [String]
    var budget: Double
    var estimatedHours: Int
    var category: GigCategory
    var urgency: GigUrgency
    var postedDate: Date
    var applicants: Int
    
    var timeAgo: String {
        let interval = Date().timeIntervalSince(postedDate)
        let minutes = Int(interval / 60)
        let hours = Int(interval / 3600)
        let days = Int(interval / 86400)
        
        if minutes < 1 {
            return "JUST NOW"
        } else if minutes < 60 {
            return "\(minutes)M AGO"
        } else if hours < 24 {
            return "\(hours)H AGO"
        } else {
            return "\(days)D AGO"
        }
    }
}

enum GigUrgency: String, Codable, Hashable, CaseIterable {
    case urgent = "URGENT"
    case normal = "NORMAL"
    case flexible = "FLEXIBLE"
    
    var color: String {
        switch self {
        case .urgent: return "red"
        case .normal: return "accent"
        case .flexible: return "textSecondary"
        }
    }
}
