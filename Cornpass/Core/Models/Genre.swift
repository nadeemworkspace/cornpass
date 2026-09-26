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
    // renders empty.
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
    ]
}
