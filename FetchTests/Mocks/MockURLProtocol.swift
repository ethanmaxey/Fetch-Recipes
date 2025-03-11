//
//  MockURLProtocol.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import Foundation

import Foundation

final class MockURLProtocol: URLProtocol {
    static var mockData: Data?
    static var mockResponse: URLResponse?
    static var mockError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    /// Ensure these run on the main thread to prevent crashes.
    override func startLoading() {
        if let mockError = MockURLProtocol.mockError {
            // Simulate an error on the main thread
            DispatchQueue.main.async {
                self.client?.urlProtocol(self, didFailWithError: mockError)
            }
        } else {
            if let mockResponse = MockURLProtocol.mockResponse {
                // Simulate a response on the main thread
                DispatchQueue.main.async {
                    self.client?.urlProtocol(self, didReceive: mockResponse, cacheStoragePolicy: .notAllowed)
                }
            }
            if let mockData = MockURLProtocol.mockData {
                // Simulate data loading on the main thread
                DispatchQueue.main.async {
                    self.client?.urlProtocol(self, didLoad: mockData)
                }
            }
            // Simulate finishing on the main thread
            DispatchQueue.main.async {
                self.client?.urlProtocolDidFinishLoading(self)
            }
        }
    }

    override func stopLoading() {
        // No-op
    }
}
