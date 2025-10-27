//
//  LoadingOverlay.swift
//  OolabMoviestest
//
//  Created by Mohamed Ali BELHADJ on 27/10/2025.
//

import Foundation
import SwiftUI

/// A simple full-screen loading overlay with a dimmed background.
struct LoadingOverlay: View {
    var text: String? = nil

    var body: some View {
        ZStack {
            Color.black.opacity(0.25).ignoresSafeArea()
            VStack(spacing: 12) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.2)
                if let text, !text.isEmpty {
                    Text(text)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.2), value: text)
    }
}
/// View modifier to easily attach the overlay to any view.
struct LoadingOverlayModifier: ViewModifier {
    let isLoading: Bool
    let text: String?

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                LoadingOverlay(text: text)
            }
        }
    }
}
extension View {
    /// Attach a full-screen loading overlay.
    func loadingOverlay(_ isLoading: Bool, text: String? = nil) -> some View {
        modifier(LoadingOverlayModifier(isLoading: isLoading, text: text))
    }
}
