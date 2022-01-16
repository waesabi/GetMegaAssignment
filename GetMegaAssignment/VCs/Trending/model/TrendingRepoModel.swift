//
//  TrendingRepoModel.swift
//  GetMegaAssignment
//
//  Created by sanket kumar on 16/01/22.
//

import Foundation

struct TrendingRepoModel: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [TrendingRepoItem]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct TrendingRepoItem: Codable {
    let id: Int?
    let name, fullName: String?
    let owner: RepoOwner?
    let htmlURL: String?
    let description: String?
    let homepage: String?
    let language: String?
    let forksCount, watchers: Int?
    var isExpanded: Bool? // used to maintain cell state
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
        case description = "description"
        case homepage, language
        case forksCount = "forks_count"
        case watchers, isExpanded
    }
}

struct RepoOwner: Codable {
    let login: String?
    let avatarURL, htmlURL: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}
