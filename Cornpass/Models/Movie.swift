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
    let videoURL: String
}

extension Movie {
    
    // Main Poster
    static let heroMovies: [Movie] = [
        Movie(
            title: "Alien: Romulus",
            badge: "HOT",
            genre: "Sci-Fi",
            rating: "R",
            duration: "1h 56m",
            image: "alien_home",
            videoURL: "https://www.youtube.com/watch?v=OzY2r2JXsDM"
        ),
        
        Movie(
            title: "Arrival",
            badge: "NEW",
            genre: "Mystery",
            rating: "PG-13",
            duration: "1h 56m",
            image: "arrival_home",
            videoURL: "https://www.youtube.com/watch?v=tFMo3UJ4B4g"
        ),
        
        Movie(
            title: "Dune: Part Two",
            badge: "NEW",
            genre: "Sci-Fi",
            rating: "PG-13",
            duration: "2h 46m",
            image: "dune_home",
            videoURL: "https://www.youtube.com/watch?v=Way9Dexny3w"
        ),
        
        Movie(
            title: "Oppenheimer",
            badge: "HOT",
            genre: "Drama",
            rating: "R",
            duration: "3h 0m",
            image: "oppenheimer_home",
            videoURL: "https://www.youtube.com/watch?v=uYPbbksJxIg"
        )
    ]
    
    static let nowShowingMovies: [Movie] = [
        Movie(
            title: "Peaky Blinders",
            badge: "TOP",
            genre: "Crime",
            rating: "TV-MA",
            duration: "1h 0m",
            image: "peakyblinders_home",
            videoURL: "https://www.youtube.com/watch?v=oVzVdvGIC7U"
        ),
        
        Movie(
            title: "Avatar 2",
            badge: "NEW",
            genre: "Action",
            rating: "PG-13",
            duration: "3h 12m",
            image: "avatar2_home",
            videoURL: "https://www.youtube.com/watch?v=d9MyW72ELq0"
        ),
        
        Movie(
            title: "Interstellar",
            badge: "",
            genre: "Sci-Fi",
            rating: "PG-13",
            duration: "2h 49m",
            image: "interstellar_home",
            videoURL: "https://www.youtube.com/watch?v=zSWdZVtXT7E"
        )
    ]

    static let comingSoonMovies: [Movie] = [
        Movie(
            title: "Minions 3",
            badge: "NEW",
            genre: "Animation",
            rating: "PG",
            duration: "1h 30m",
            image: "minions_home",
            videoURL: "https://www.youtube.com/watch?v=P9AYBWv7jto"
        ),
        
        Movie(
            title: "Napoleon",
            badge: "HOT",
            genre: "History",
            rating: "R",
            duration: "2h 38m",
            image: "nepolean_home",
            videoURL: "https://www.youtube.com/watch?v=OAZWXUkrjPc"
        ),
        
        Movie(
            title: "Gladiator II",
            badge: "TOP",
            genre: "Action",
            rating: "R",
            duration: "2h 28m",
            image: "gladiator_home",
            videoURL: "https://www.youtube.com/watch?v=4rgYUipGJNo"
        ),
        
        Movie(
            title: "Avengers Endgame",
            badge: "TOP",
            genre: "SciFi",
            rating: "R",
            duration: "2h 28m",
            image: "endgame_home",
            videoURL: "https://www.youtube.com/watch?v=TcMBFSGVi1c"
        )
    ]

    static let animationMovies: [Movie] = [
        Movie(
            title: "Penguins of Madagascar",
            badge: "HOT",
            genre: "Animation",
            rating: "PG",
            duration: "1h 32m",
            image: "pom_home",
            videoURL: "https://www.youtube.com/watch?v=KCVjsbmVi0E"
        ),
        
        Movie(
            title: "Lion King",
            badge: "HOT",
            genre: "Animation",
            rating: "G",
            duration: "1h 28m",
            image: "lionking_home",
            videoURL: "https://www.youtube.com/watch?v=7TavVZMewpY"
        ),
        
        Movie(
            title: "Brave",
            badge: "NEW",
            genre: "Animation",
            rating: "PG",
            duration: "1h 33m",
            image: "brave_home",
            videoURL: "https://www.youtube.com/watch?v=TEHWDA_6e3M"
        ),
        
        Movie(
            title: "Up",
            badge: "TOP",
            genre: "Animation",
            rating: "PG",
            duration: "1h 33m",
            image: "up_home",
            videoURL: "https://www.youtube.com/watch?v=pkqzFUhGPJg"
        )
    ]

}
