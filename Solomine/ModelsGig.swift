//
//  Gig.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/3/26.
//

import Foundation

enum GigCategory: String, CaseIterable, Codable {
    case mobileDev = "MOBILE DEV"
    case webDev = "WEB DEV"
    case aiML = "AI/ML"
    case automation = "AUTOMATION"
    case design = "DESIGN"
    case apiBackend = "API/BACKEND"
    case vibeCoding = "VIBE CODING"
    case other = "OTHER"
}

struct Gig: Identifiable, Codable, Hashable {
    let id: UUID
    var freelancerId: UUID
    var title: String
    var description: String
    var deliverables: [String]
    var turnaroundDays: Int
    var price: Double
    var categories: [GigCategory]
    var createdAt: Date
    
    init(
        id: UUID = UUID(),
        freelancerId: UUID,
        title: String,
        description: String,
        deliverables: [String],
        turnaroundDays: Int,
        price: Double,
        categories: [GigCategory],
        createdAt: Date = Date()
    ) {
        self.id = id
        self.freelancerId = freelancerId
        self.title = title
        self.description = description
        self.deliverables = deliverables
        self.turnaroundDays = turnaroundDays
        self.price = price
        self.categories = categories
        self.createdAt = createdAt
    }
}
