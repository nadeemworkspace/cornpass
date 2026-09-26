//
//  RemoteImage.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

// Loads a TMDB image URL, filling its container. Used everywhere a movie
// poster/backdrop is shown, since none of that art ships with the app anymore.
struct RemoteImage: View {
    let url: URL?
    var contentMode: ContentMode = .fill

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .empty:
                Color(white: 0.12)
                    .overlay(ProgressView().tint(.white.opacity(0.6)))
            case .failure:
                Color(white: 0.12)
            @unknown default:
                Color(white: 0.12)
            }
        }
    }
}

struct PosterCard: View {
    let movie: Movie

    var body: some View {
        RemoteImage(url: movie.backdropURL)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
}
