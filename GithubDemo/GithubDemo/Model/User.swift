//
//  User.swift
//  GithubDemo
//
//  Created by Sagar on 18/12/25.
//

import Foundation

struct User: Codable {
    var login: String
    var name: String?
    var avatarUrl: String
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var followers: Int
    var following: Int
    var createdAt: Date
    
}
