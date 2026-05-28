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
    static let all: [Genre] = [
        Genre(name: "Romance",    emoji: "💕"),
        Genre(name: "Action",     emoji: "💣"),
        Genre(name: "Comedy",     emoji: "🤣"),
        Genre(name: "Adventure",  emoji: "🗺️"),
        Genre(name: "Fantasy",    emoji: "🦄"),
        Genre(name: "Horror",     emoji: "🎃"),
        Genre(name: "Cartoon",    emoji: "🧸"),
        Genre(name: "Drama",      emoji: "😢"),
        Genre(name: "Mystery",    emoji: "🔍"),
        Genre(name: "Biography",  emoji: "👨‍🚀"),
        Genre(name: "History",    emoji: "📙"),
        Genre(name: "Sport",      emoji: "🏈"),
        Genre(name: "Sci-fi",     emoji: "🌏"),
    ]
}
