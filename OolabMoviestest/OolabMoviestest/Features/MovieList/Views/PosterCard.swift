//
//  PosterCard.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation
import SwiftUI

struct PosterCard: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .empty:
                    ZStack { Color.gray.opacity(0.15); ProgressView() }
                case .success(let img):
                    img.resizable().scaledToFill()
                case .failure:
                    ZStack { Color.gray.opacity(0.15); Image(systemName: "photo") }
                @unknown default:
                    Color.gray.opacity(0.15)
                }
            }
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(movie.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40, alignment: .top)
                .layoutPriority(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}
