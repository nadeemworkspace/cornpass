//
//  Movie.swift
//  Cornpass
//
//  Created by muhammed.nadeem.m.a on 27/05/26.
//

import SwiftUI

struct MovieResponse {
    let heroMovies: [Movie]
    let nowShowingMovies: [Movie]
    let comingSoonMovies: [Movie]
    let animationMovies: [Movie]
}

struct Movie: Identifiable, Hashable {
    let id: Int
    let title: String
    let badge: String
    let genre: String
    let rating: String
    let duration: String
    let posterURL: URL?
    let backdropURL: URL?
    let videoURL: String
    // Extra UI Data
    let description: String
    let ageBadge: String
    let languageTags: [String]
    // Ratings — TMDB has no IMDb/Rotten Tomatoes/CornPass feed, so all three
    // are derived from TMDB's own vote_average.
    let imdbRating: String
    let rottenTomatoesRating: String
    let cornPassRating: String
    // Other
    let gallery: [URL]
    let director: [String]
    let writers: [String]
    let stars: [String]
    let classification: String
    let comingSoon: Bool
}

extension Movie {
    // The detail endpoint recomputes `comingSoon`/`badge` from the release
    // date alone, which can disagree with TMDB's own "upcoming" listing
    // (see `MovieRepository.mapSummary(forceComingSoon:)`) — e.g. a movie
    // TMDB still lists as upcoming but whose release date has technically
    // passed. Once a screen seeds itself from a coming-soon summary, keep
    // that flag after the fuller detail response overwrites everything else.
    func preservingComingSoon(from seed: Movie) -> Movie {
        guard seed.comingSoon, !comingSoon else { return self }
        return Movie(
            id: id,
            title: title,
            badge: seed.badge,
            genre: genre,
            rating: rating,
            duration: duration,
            posterURL: posterURL,
            backdropURL: backdropURL,
            videoURL: videoURL,
            description: description,
            ageBadge: ageBadge,
            languageTags: languageTags,
            imdbRating: imdbRating,
            rottenTomatoesRating: rottenTomatoesRating,
            cornPassRating: cornPassRating,
            gallery: gallery,
            director: director,
            writers: writers,
            stars: stars,
            classification: classification,
            comingSoon: true
        )
    }
}

// A search hit: the summary-level `Movie` (enough to open MovieDetailView)
// plus the extra fields the search row shows that `Movie` flattens away.
struct MovieSearchResult: Identifiable, Hashable {
    let movie: Movie
    let genres: [String]
    let releaseDate: Date?

    var id: Int { movie.id }
}

extension Movie {
    static let dummy = Movie(
        id: 1,
        title: "Alien: Romulus",
        badge: "HOT",
        genre: "Sci-Fi",
        rating: "R",
        duration: "1h 56m",
        posterURL: TMDBImage.poster("/pIQCe5tSAyKB1YOVQ2NlEHwZhQF.jpg"),
        backdropURL: TMDBImage.backdrop("/xoRJ9YnrujqE8vdoW0RUOrDG3Vg.jpg"),
        videoURL: "https://www.youtube.com/watch?v=OzY2r2JXsDM",
        description: "Young space colonizers come face to face with the most terrifying life-form in the universe.",
        ageBadge: "R",
        languageTags: ["EN"],
        imdbRating: "8.1/10",
        rottenTomatoesRating: "81%",
        cornPassRating: "8.4/10",
        gallery: [],
        director: ["Fede Álvarez"],
        writers: ["Fede Álvarez", "Rodo Sayagues"],
        stars: ["Cailee Spaeny", "David Jonsson", "Archie Renaux"],
        classification: "R",
        comingSoon: false
    )
}
