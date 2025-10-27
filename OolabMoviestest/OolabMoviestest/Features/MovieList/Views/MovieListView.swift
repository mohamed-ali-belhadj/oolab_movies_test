//
//  MovieListView.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation
import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    private let grid = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("WOOKIE MOVIES")
        }
        .loadingOverlay(viewModel.state == .loading, text: "Loading movies…")
        .task { await viewModel.load() }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            Color.clear
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .failed(let message):
            VStack(spacing: 12) {
                Text("Something went wrong").font(.headline)
                Text(message).multilineTextAlignment(.center)
                Button("Retry") { Task { await viewModel.load() } }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .refreshable { await viewModel.load() }

        case .loaded(let movies):
            ScrollView {
                LazyVGrid(columns: grid, alignment: .leading, spacing: 18) {
                    ForEach(movies) { movie in
                        NavigationLink(value: movie) {
                            PosterCard(movie: movie)
                                .frame(height: 240)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
            .refreshable { await viewModel.load() }
            .scrollIndicators(.hidden)
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(viewModel: MovieDetailViewModel(movie: movie))
            }
        }
    }
}


