//
//  ImageCacheTests.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import XCTest

@testable import Fetch

final class ImageCacheTests: XCTestCase {
    private var mockURLSession: URLSession!
    private let testURLString = "https://example.com/image.jpg"
    private let testImageData = UIImage(systemName: "photo")!.pngData()!

    override func setUp() {
        super.setUp()
        // Configure URLSession to use MockURLProtocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockURLSession = URLSession(configuration: config)
        ImageCache.cache.removeAllObjects() // Clear cache before each test
    }

    override func tearDown() {
        mockURLSession = nil
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockResponse = nil
        MockURLProtocol.mockError = nil
        super.tearDown()
    }

    // MARK: - Cache Hit Tests

    func testLoadImage_CacheHit() async throws {
        // Pre-cache the image
        let cachedImage = UIImage(systemName: "photo")!
        ImageCache.cache.setObject(cachedImage, forKey: testURLString as NSString)

        // Load the image
        let image = try await ImageCache.loadImage(from: testURLString, using: mockURLSession)

        // Verify the cached image is returned
        XCTAssertEqual(image.pngData(), cachedImage.pngData())
    }

    // MARK: - Cache Miss Tests

    func testLoadImage_CacheMiss_Success() async throws {
        // Mock successful network response
        MockURLProtocol.mockData = testImageData
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: testURLString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // Load the image
        let image = try await ImageCache.loadImage(from: testURLString, using: mockURLSession)

        // Verify the image is loaded and cached
        XCTAssertEqual(image.pngData()?.description, testImageData.description)
        XCTAssertNotNil(ImageCache.cache.object(forKey: testURLString as NSString))
    }

    // MARK: - Error Tests

    func testLoadImage_InvalidResponse() async {
        // Mock invalid response (status code 404)
        MockURLProtocol.mockData = testImageData
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: testURLString)!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await ImageCache.loadImage(from: testURLString, using: mockURLSession)
            XCTFail("Expected NetworkError.invalidResponse to be thrown")
        } catch NetworkError.invalidResponse {
            // Expected error
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testLoadImage_InvalidImageData() async {
        // Mock invalid image data
        MockURLProtocol.mockData = Data() // Empty data
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: testURLString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            _ = try await ImageCache.loadImage(from: testURLString, using: mockURLSession)
            XCTFail("Expected CacheError.badData to be thrown")
        } catch {
            // Expected error
        }
    }
}
