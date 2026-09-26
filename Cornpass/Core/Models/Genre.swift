//
//  Genre.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 24/05/26.
//

import Foundation

struct Genre: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let emoji: String
    var isSelected: Bool = false
}

extension Genre {
    // Used only if the TMDB genre list request fails, so the picker never
    // renders empty. Mirrors TMDB's full genre list (see
    // `MovieRepository.emoji(for:)`) rather than a partial subset, so the
    // fallback fills the picker board the same way the real API response does.
    static let fallback: [Genre] = [
        Genre(name: "Romance",   emoji: "💕"),
        Genre(name: "Action",    emoji: "💣"),
        Genre(name: "Comedy",    emoji: "🤣"),
        Genre(name: "Adventure", emoji: "🗺️"),
        Genre(name: "Fantasy",   emoji: "🦄"),
        Genre(name: "Horror",    emoji: "🎃"),
        Genre(name: "Animation", emoji: "🧸"),
        Genre(name: "Drama",     emoji: "😢"),
        Genre(name: "Mystery",   emoji: "🔍"),
        Genre(name: "History",   emoji: "📙"),
        Genre(name: "Science Fiction", emoji: "🌏"),
        Genre(name: "Crime",       emoji: "🕵️"),
        Genre(name: "Documentary", emoji: "🎥"),
        Genre(name: "Family",      emoji: "👨‍👩‍👧"),
        Genre(name: "Music",       emoji: "🎵"),
        Genre(name: "TV Movie",    emoji: "📺"),
        Genre(name: "Thriller",    emoji: "🔪"),
        Genre(name: "War",         emoji: "⚔️"),
        Genre(name: "Western",     emoji: "🤠"),
    ]
}
