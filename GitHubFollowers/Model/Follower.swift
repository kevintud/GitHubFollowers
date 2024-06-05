//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/17/24.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    
    //for hashing specific entity
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(login)
//    }
}
