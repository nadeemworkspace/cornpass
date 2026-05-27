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
    Movie(title: "Alien", badge: "HOT", genre: "Sci-Fi", rating: "R", duration: "1h 56m", image: "alien_home"),
    Movie(title: "Arrival", badge: "NEW", genre: "Mystery", rating: "PG-13", duration: "1h 56m", image: "arrival_home"),
    Movie(title: "Dune: Part Two", badge: "NEW", genre: "Sci-Fi", rating: "PG-13", duration: "2h 46m", image: "dune_home"),
    Movie(title: "Oppenheimer", badge: "HOT", genre: "Drama", rating: "R", duration: "3h 0m", image: "oppenheimer_home"),
]

let nowShowingMovies: [Movie] = [
    Movie(title: "Peaky Blinders", badge: "", genre: "Crime", rating: "TV-MA", duration: "1h 0m", image: "peakyblinders_home"),
    Movie(title: "Avatar 2", badge: "", genre: "Action", rating: "PG-13", duration: "3h 12m", image: "avatar2_home"),
    Movie(title: "Interstellar", badge: "", genre: "Sci-Fi", rating: "PG-13", duration: "2h 49m", image: "interstellar_home"),
]

let comingSoonMovies: [Movie] = [
    Movie(title: "Minions 3", badge: "SO ON", genre: "Animation", rating: "PG", duration: "1h 30m", image: "minions_home"),
    Movie(title: "Napoleon", badge: "SO ON", genre: "History", rating: "R", duration: "2h 38m", image: "nepolean_home"),
    Movie(title: "Gladiator II", badge: "SO ON", genre: "Action", rating: "R", duration: "2h 28m", image: "gladiator_home"),
    Movie(title: "Avengers Endgame", badge: "SO ON", genre: "SciFi", rating: "R", duration: "2h 28m", image: "endgame_home"),
]

let animationMovies: [Movie] = [
    Movie(title: "Penguins of Madagascar", badge: "", genre: "Animation", rating: "PG", duration: "1h 32m", image: "pom_home"),
    Movie(title: "Lion King", badge: "", genre: "Animation", rating: "G", duration: "1h 28m", image: "lionking_home"),
    Movie(title: "Brave", badge: "", genre: "Animation", rating: "PG", duration: "1h 33m", image: "brave_home"),
    Movie(title: "Up", badge: "", genre: "Animation", rating: "PG", duration: "1h 33m", image: "up_home")
]
