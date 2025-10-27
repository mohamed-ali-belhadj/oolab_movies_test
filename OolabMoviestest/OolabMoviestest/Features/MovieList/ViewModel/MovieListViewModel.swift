//
//  MovieListViewModel.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation
final class MovieListViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case loaded([Movie])
        case failed(String)
    }
    @Published private(set) var state: State = .idle
    private let service: MovieService

    init(service: MovieService = DefaultMovieService()) {
        self.service = service
    }

    /// Runs on the main actor because it mutates @Published state.
    @MainActor
    func load() async {
        state = .loading
        do {
            let movies = try await service.fetchMovies()
            state = .loaded(movies.sorted { $0.title < $1.title })
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
