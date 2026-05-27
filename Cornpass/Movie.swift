//
//  Movie.swift
//  Cornpass
//
//  Created by muhammed.nadeem.m.a on 27/05/26.
//

import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let badge: String
    let genre: String
    let rating: String
    let duration: String
    let image: String
}

struct Genre1: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
}

let heroMovies: [Movie] = [
    Movie(title: "Arrival", badge: "NEW", genre: "Mystery", rating: "PG-13", duration: "1h 56m", image: "arrival_home"),
    Movie(title: "Dune: Part Two", badge: "NEW", genre: "Sci-Fi", rating: "PG-13", duration: "2h 46m", image: "dune_home"),
    Movie(title: "Oppenheimer", badge: "HOT", genre: "Drama", rating: "R", duration: "3h 0m", image: "oppenheimer_home"),
]

let nowShowingMovies: [Movie] = [
    Movie(title: "Peaky Blinders", badge: "", genre: "Crime", rating: "TV-MA", duration: "1h 0m", image: ""),
    Movie(title: "Avatar 2", badge: "", genre: "Action", rating: "PG-13", duration: "3h 12m", image: ""),
    Movie(title: "Interstellar", badge: "", genre: "Sci-Fi", rating: "PG-13", duration: "2h 49m", image: ""),
]

let comingSoonMovies: [Movie] = [
    Movie(title: "Minions 3", badge: "SO ON", genre: "Animation", rating: "PG", duration: "1h 30m", image: ""),
    Movie(title: "Napoleon", badge: "SO ON", genre: "History", rating: "R", duration: "2h 38m", image: ""),
    Movie(title: "Gladiator II", badge: "SO ON", genre: "Action", rating: "R", duration: "2h 28m", image: ""),
    Movie(title: "Furiosa", badge: "SO ON", genre: "Action", rating: "R", duration: "2h 28m", image: ""),
]

let genres: [Genre1] = [
    Genre1(icon: "🗺️", name: "Adventure"),
    Genre1(icon: "😄", name: "Comedy"),
    Genre1(icon: "💕", name: "Romance"),
    Genre1(icon: "🔪", name: "Thriller"),
    Genre1(icon: "👻", name: "Horror"),
]

let animationMovies: [Movie] = [
    Movie(title: "Penguins", badge: "", genre: "Animation", rating: "PG", duration: "1h 32m", image: ""),
    Movie(title: "Lion King", badge: "", genre: "Animation", rating: "G", duration: "1h 28m", image: ""),
    Movie(title: "Brave", badge: "", genre: "Animation", rating: "PG", duration: "1h 33m", image: ""),
]
