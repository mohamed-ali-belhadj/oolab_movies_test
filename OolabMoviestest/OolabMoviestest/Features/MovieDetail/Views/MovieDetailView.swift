//
//  MovieDetailView.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: viewModel.movie.backdropURL) { phase in
                    switch phase {
                    case .empty:
                        ZStack { Color.gray.opacity(0.2); ProgressView() }
                    case .success(let img):
                        img.resizable().scaledToFill()
                    case .failure:
                        ZStack { Color.gray.opacity(0.2); Image(systemName: "photo") }
                    @unknown default:
                        Color.gray.opacity(0.2)
                    }
                }
                .frame(height: 190)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                HStack(alignment: .top, spacing: 16) {
                    AsyncImage(url: viewModel.movie.posterURL) { phase in
                        switch phase {
                        case .empty:
                            ZStack { Color.gray.opacity(0.2); ProgressView() }
                        case .success(let img):
                            img.resizable().scaledToFill()
                        case .failure:
                            ZStack { Color.gray.opacity(0.2); Image(systemName: "photo") }
                        @unknown default:
                            Color.gray.opacity(0.2)
                        }
                    }
                    .frame(width: 90, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.titleText)
                            .font(.title3.weight(.semibold))
                            .lineLimit(2)

                        StarsRow(filled: viewModel.ratingStars)

                        Text(viewModel.yearLengthDirectorText)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                Text(viewModel.castText)
                    .font(.subheadline)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Movie Description")
                        .font(.headline)
                    Text(viewModel.movie.overview)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 12)
            }
            .padding(16)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

