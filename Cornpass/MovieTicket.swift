//
//  MovieTicket.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 25/05/26.
//

import Foundation

struct MovieTicket: Identifiable {
    let id = UUID()
    let movieTitle: String
    let genre: String
    let rating: String
    let duration: String
    let cinema: String
    let date: String
    let time: String
    let ticketCount: Int
    let imageName: String
    
    static let tickets: [MovieTicket] = [
        MovieTicket(
            movieTitle: "Oppenheimer",
            genre: "Biography",
            rating: "PG-13",
            duration: "1h 56m",
            cinema: "Stars (90° Mall)",
            date: "13.04.2025",
            time: "22:15",
            ticketCount: 3,
            imageName: "oppenheimer"
        ),
        MovieTicket(
            movieTitle: "Luca",
            genre: "Cartoon",
            rating: "PG",
            duration: "1h 46m",
            cinema: "VOX (City Center)",
            date: "08.02.2025",
            time: "00:45",
            ticketCount: 2,
            imageName: "luca"
        ),
        MovieTicket(
            movieTitle: "Avatar",
            genre: "Fantasy",
            rating: "PG-13",
            duration: "2h 08m",
            cinema: "Delox (90° Mall)",
            date: "26.01.2025",
            time: "14:00",
            ticketCount: 5,
            imageName: "avatar"
        ),
        MovieTicket(
            movieTitle: "Michael",
            genre: "Biography",
            rating: "PG-13",
            duration: "2h 12m",
            cinema: "AMC Grand",
            date: "18.05.2025",
            time: "20:30",
            ticketCount: 4,
            imageName: "michael"
        ),
        MovieTicket(
            movieTitle: "Pacific Rim",
            genre: "Sci-Fi",
            rating: "PG-13",
            duration: "2h 11m",
            cinema: "IMAX Downtown",
            date: "21.05.2025",
            time: "19:00",
            ticketCount: 2,
            imageName: "pacific_rim"
        ),
        MovieTicket(
            movieTitle: "Joker",
            genre: "Thriller",
            rating: "R",
            duration: "2h 02m",
            cinema: "Cinema City",
            date: "25.05.2025",
            time: "23:15",
            ticketCount: 1,
            imageName: "joker"
        )
    ]
}
