//
//  RecipeServiceTests.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import XCTest

@testable import Fetch

final class RecipeServiceTests: XCTestCase {
    private var mockURLSession: URLSession!

    override func setUp() {
        super.setUp()
        // Configure URLSession to use MockURLProtocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockURLSession = URLSession(configuration: config)
    }

    override func tearDown() {
        mockURLSession = nil
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockResponse = nil
        MockURLProtocol.mockError = nil
        super.tearDown()
    }

    // MARK: - Successful Response Tests

    func testFetchRecipes_Success() async throws {
        // Mock valid JSON data
        let recipes = [
            Recipe(
                id: UUID(),
                cuisine: "British",
                name: "Bakewell Tart",
                photoURLSmall: "https://example.com/small.jpg",
                photoURLLarge: "https://example.com/large.jpg",
                sourceURL: "https://example.com",
                youtubeURL: "https://youtube.com"
            )
        ]
        let recipesData = try JSONEncoder().encode(RecipeResponse(recipes: recipes))
        MockURLProtocol.mockData = recipesData
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: RecipeServiceTests.validURLString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Fetch recipes
        let fetchedRecipes = try await RecipeService.fetchRecipes(using: RecipeServiceTests.validURLString, session: mockURLSession)

        // Verify the fetched recipes match the mock data
        XCTAssertEqual(fetchedRecipes.count, 1)
        XCTAssertEqual(fetchedRecipes[0].name, "Bakewell Tart")
    }

    // MARK: - Error Tests

    func testFetchRecipes_InvalidResponse() async {
        // Mock invalid response (status code 404)
        MockURLProtocol.mockData = Data()
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: RecipeServiceTests.validURLString)!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await RecipeService.fetchRecipes(using: RecipeServiceTests.validURLString, session: mockURLSession)
            XCTFail("Expected NetworkError.invalidResponse to be thrown")
        } catch NetworkError.invalidResponse {
            // Expected error
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testFetchRecipes_MalformedData() async {
        // Mock malformed JSON data
        MockURLProtocol.mockData = Data("invalid json".utf8)
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: RecipeServiceTests.validURLString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await RecipeService.fetchRecipes(using: RecipeServiceTests.validURLString, session: mockURLSession)
            XCTFail("Expected DecodingError to be thrown")
        } catch is DecodingError {
            // Expected error
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testFetchRecipes_EmptyData() async {
        // Mock empty JSON data
        MockURLProtocol.mockData = Data()
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: RecipeServiceTests.emptyURLString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await RecipeService.fetchRecipes(using: RecipeServiceTests.emptyURLString, session: mockURLSession)
            XCTFail("Expected DecodingError to be thrown")
        } catch is DecodingError {
            // Expected error
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}
extension RecipeServiceTests {
    private static let validURLString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private static let invalidURLString = "invalid-url"
    private static let malformedURLString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    private static let emptyURLString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}
