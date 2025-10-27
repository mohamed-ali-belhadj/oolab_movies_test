//
//  MoviesResponse.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation

struct MoviesResponse {
    let movies: [Movie]
}

extension MoviesResponse {
    init(data: Data) throws {
           let json = try JSONSerialization.jsonObject(with: data, options: [])
           guard let root = json as? [String: Any],
                 let items = root["movies"] as? [[String: Any]] else {
               throw ParseError.invalidRoot
           }
           self.movies = try items.map { try Movie(dict: $0) }
    }
}
