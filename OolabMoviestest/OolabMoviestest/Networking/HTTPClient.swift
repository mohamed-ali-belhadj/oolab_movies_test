//
//  HTTPClient.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation

protocol HTTPClient {
    func get(_ url: URL, headers: [String: String]) async throws -> Data
}

final class URLSessionHTTPClient: HTTPClient {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func get(_ url: URL, headers: [String: String]) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let http = response as? HTTPURLResponse else { throw NetworkError.invalidHTTPResponse }
            guard (200...299).contains(http.statusCode) else { throw NetworkError.httpStatus(http.statusCode) }
            return data
        } catch {
            if let e = error as? URLError {
                switch e.code {
                case .notConnectedToInternet: throw NetworkError.noInternet
                case .timedOut:               throw NetworkError.requestTimedOut
                case .cancelled:              throw NetworkError.requestCancelled
                default:                      throw NetworkError.underlying(e)
                }
            }
            throw NetworkError.underlying(error)
        }
    }
}

enum NetworkError: LocalizedError {
    case noInternet
    case requestTimedOut
    case requestCancelled
    case httpStatus(Int)
    case invalidHTTPResponse
    case underlying(Error)

    var errorDescription: String? {
        switch self {
        case .noInternet:          return "No internet connection."
        case .requestTimedOut:     return "The request timed out."
        case .requestCancelled:    return "The request was cancelled."
        case .httpStatus(let c):   return "Unexpected server response (\(c))."
        case .invalidHTTPResponse: return "Invalid server response."
        case .underlying(let e):   return e.localizedDescription
        }
    }
}
