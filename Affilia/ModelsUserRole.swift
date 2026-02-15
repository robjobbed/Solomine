//
//  UserRole.swift
//  Solomine
//
//  Created by Rob Behbahani on 2/3/26.
//

import Foundation

enum UserRole: String, Codable {
    case builder = "I BUILD"
    case hirer = "I HIRE"
}

struct User: Identifiable, Codable {
    let id: UUID
    var email: String
    var role: UserRole?  // Optional - set after authentication in RoleSelectionView
    var freelancerProfile: FreelancerProfile?
    var shortlistedFreelancers: [UUID]
    
    init(
        id: UUID = UUID(),
        email: String,
        role: UserRole? = nil,  // Default to nil - user selects role after auth
        freelancerProfile: FreelancerProfile? = nil,
        shortlistedFreelancers: [UUID] = []
    ) {
        self.id = id
        self.email = email
        self.role = role
        self.freelancerProfile = freelancerProfile
        self.shortlistedFreelancers = shortlistedFreelancers
    }
}
