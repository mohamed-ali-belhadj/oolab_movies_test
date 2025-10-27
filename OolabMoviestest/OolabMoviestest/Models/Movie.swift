//
//  Movie.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation

struct Movie: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let posterURL: URL?
    let backdropURL: URL?
    let overview: String
    let imdbRating: Double
    let classification: String
    let genres: [String]
    let cast: [String]
    let directorNames: [String]
    let length: String
    let releasedOn: Date?
}

extension Movie {
    private static let apiDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .init(identifier: .iso8601)
        formatter.locale   = .init(identifier: "en_US_POSIX")
        formatter.timeZone = .init(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()

    init(dict: [String: Any]) throws {
        self.id             = try Movie.requiredStringValue(forKey: "id", in: dict)
        self.title          = try Movie.requiredStringValue(forKey: "title", in: dict)
        self.overview       = try Movie.requiredStringValue(forKey: "overview", in: dict)
        self.classification = try Movie.requiredStringValue(forKey: "classification", in: dict)
        self.imdbRating     = try Movie.requiredDoubleValue(forKey: "imdb_rating", in: dict)

        self.length = (dict["length"] as? String) ?? ""
        self.genres = (dict["genres"] as? [String]) ?? []
        self.cast   = (dict["cast"] as? [String]) ?? []

        if let directorSingle = dict["director"] as? String {
            self.directorNames = [directorSingle]
        } else if let directorList = dict["director"] as? [String] {
            self.directorNames = directorList
        } else {
            self.directorNames = []
        }

        if let posterString = dict["poster"] as? String {
            self.posterURL = URL(string: posterString)
        } else {
            self.posterURL = nil
        }

        if let backdropString = dict["backdrop"] as? String {
            self.backdropURL = URL(string: backdropString)
        } else {
            self.backdropURL = nil
        }

        if let releasedOnString = dict["released_on"] as? String {
            self.releasedOn = Movie.apiDateFormatter.date(from: releasedOnString)
        } else {
            self.releasedOn = nil
        }
    }

    private static func requiredStringValue(forKey key: String, in dict: [String: Any]) throws -> String {
        guard let value = dict[key] as? String, !value.isEmpty else {
            throw ParseError.missing(key)
        }
        return value
    }

    private static func requiredDoubleValue(forKey key: String, in dict: [String: Any]) throws -> Double {
        if let number = dict[key] as? Double { return number }
        if let string = dict[key] as? String, let number = Double(string) { return number }
        throw ParseError.invalidType(key)
    }
}
