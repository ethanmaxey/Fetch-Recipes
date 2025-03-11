//
//  ImageCache.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import UIKit

enum ImageCache {
    static let cache = NSCache<NSString, UIImage>()

    static func loadImage(
        from urlString: String,
        using session: URLSession = URLSession.shared
    ) async throws -> UIImage {
        if let cachedImage = ImageCache.cache.object(forKey: urlString as NSString) {
            return cachedImage
        }

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
        
        guard let image = UIImage(data: data) else {
            throw CacheError.badData
        }
        
        cache.setObject(image, forKey: urlString as NSString)
        
        return image
    }
}
