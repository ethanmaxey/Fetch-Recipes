//
//  Recipe.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let photoURLSmall: String?
    let photoURLLarge: String?
    let sourceURL: String?
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine, name
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
