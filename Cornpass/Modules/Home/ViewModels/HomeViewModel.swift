//
//  HomeViewModel.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI
import Observation

@Observable
class HomeViewModel {

    var movies: MovieResponse?
    var featuredMovies: [Movie] = []
    var currentFeaturedIndex: Int = 0
    var genres: [Genre] = Genre.fallback
    var currentHeroIndex: Int = 0
    var isLoading = false
    var loadError: String?

    var featuredMovie: Movie? {
        featuredMovies[safe: currentFeaturedIndex]
    }

    func load() async {
        guard movies == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            async let feed = MovieRepository.shared.homeFeed()
            async let featured = MovieRepository.shared.featuredMovies()
            async let fetchedGenres = MovieRepository.shared.genres()

            movies = try await feed
            featuredMovies = (try? await featured) ?? []
            if let fetchedGenres = try? await fetchedGenres, !fetchedGenres.isEmpty {
                genres = fetchedGenres
            }
            loadError = nil
        } catch {
            loadError = "Couldn't load movies. Check your connection and try again."
        }
    }

    func rotateFeaturedMovie() async {
        guard featuredMovies.count > 1 else { return }
        while !Task.isCancelled {
            try? await Task.sleep(for: .seconds(10))
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 0.6)) {
                currentFeaturedIndex = (currentFeaturedIndex + 1) % featuredMovies.count
            }
        }
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
