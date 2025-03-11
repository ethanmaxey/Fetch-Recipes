//
//  RecipeService.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import Foundation

enum RecipeService {
    /// Fetches a list of recipes from the given urlString.
    /// - Parameters:
    ///     - urlString: A ``String`` that hosts a list of recipes.
    ///     - session: A ``URLSession`` to use for the network request. Defaults to `URLSession.shared`.
    ///
    /// - Returns: A list of ``Recipe`` objects.
    static func fetchRecipes(
        using urlString: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json",
        session: URLSession = URLSession.shared
    ) async throws -> [Recipe] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, urlResponse) = try await session.data(from: url)
        
        // Check if the response is an HTTPURLResponse and if the status code indicates success
        guard
            let httpResponse = urlResponse as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode)
        else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(RecipeResponse.self, from: data).recipes
    }
}
