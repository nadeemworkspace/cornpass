//
//  HomeViewModel.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import Foundation
import Observation

@Observable
class HomeViewModel {

    var movies: MovieResponse?
    var featuredMovie: Movie?
    var genres: [Genre] = Genre.fallback
    var currentPosterIndex: Int = 0
    var isLoading = false
    var loadError: String?

    func load() async {
        guard movies == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            async let feed = MovieRepository.shared.homeFeed()
            async let featured = MovieRepository.shared.featuredMovie()
            async let fetchedGenres = MovieRepository.shared.genres()

            movies = try await feed
            featuredMovie = try? await featured
            if let fetchedGenres = try? await fetchedGenres, !fetchedGenres.isEmpty {
                genres = fetchedGenres
            }
            loadError = nil
        } catch {
            loadError = "Couldn't load movies. Check your connection and try again."
        }
    }
}
