//
//  MovieDetailViewModel.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    let movie: Movie

    init(movie: Movie) { self.movie = movie }

    var titleText: String { movie.title }
    var yearLengthDirectorText: String {
        let year = DateParser.yearString(from: movie.releasedOn)
        let director = movie.directorNames.joined(separator: ", ")
        return [year, movie.length, director]
            .filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
            .joined(separator: " | ")
    }

    var castText: String {
        "Cast: " + (movie.cast.isEmpty ? "—" : movie.cast.joined(separator: ", "))
    }

    var ratingStars: Int { Int(round(movie.imdbRating / 2.0)) } 
}
