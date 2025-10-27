//
//  MovieService.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation

protocol MovieService {
    func fetchMovies() async throws -> [Movie]
}

struct DefaultMovieService: MovieService {
    private let httpClient: HTTPClient
    private let endpointURL = URL(string: "https://wookie.codesubmit.io/movies")!
    private let headers     = ["Authorization": "Bearer Wookie2019"]

    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }

    func fetchMovies() async throws -> [Movie] {
        let data = try await httpClient.get(endpointURL, headers: headers)
        let response = try MoviesResponse(data: data)
        return response.movies
    }
}
