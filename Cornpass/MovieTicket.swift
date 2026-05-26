//
//  MovieTicket.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 25/05/26.
//

import Foundation

struct MovieTicket: Identifiable {
    let id = UUID()
    // Movie Details
    let movieTitle: String
    let genre: String
    let rating: String
    let language: String
    let format: String
    let audioFormat: String
    let duration: String
    let imageName: String
    // Cinema Details
    let cinema: String
    let hall: String
    // Booking Details
    let date: String
    let time: String
    let seats: String
    let ticketCount: Int
    let totalAmount: Double
    let currency: String
    
    static let tickets: [MovieTicket] = [
        MovieTicket(
            movieTitle: "Oppenheimer",
            genre: "Biography",
            rating: "+13",
            language: "EN",
            format: "ScreenX",
            audioFormat: "Dolby Atmos",
            duration: "1h 56m",
            imageName: "oppenheimer",
            cinema: "Stars (90° Mall)",
            hall: "4th",
            date: "13.04.2025",
            time: "22:15",
            seats: "Row E (5,6,7)",
            ticketCount: 3,
            totalAmount: 59.98,
            currency: "USD"
        ),
        MovieTicket(
            movieTitle: "Luca",
            genre: "Animation",
            rating: "PG",
            language: "EN",
            format: "IMAX",
            audioFormat: "Dolby 7.1",
            duration: "1h 46m",
            imageName: "luca",
            cinema: "VOX (City Center)",
            hall: "2nd",
            date: "08.02.2025",
            time: "00:45",
            seats: "Row C (1,2)",
            ticketCount: 2,
            totalAmount: 24.99,
            currency: "USD"
        ),
        MovieTicket(
            movieTitle: "Avatar",
            genre: "Fantasy",
            rating: "PG-13",
            language: "EN",
            format: "IMAX 3D",
            audioFormat: "Dolby Atmos",
            duration: "2h 08m",
            imageName: "avatar",
            cinema: "Delox (90° Mall)",
            hall: "1st",
            date: "26.01.2025",
            time: "14:00",
            seats: "Row F (7,8,9,10,11)",
            ticketCount: 5,
            totalAmount: 89.99,
            currency: "USD"
        ),
        MovieTicket(
            movieTitle: "Michael",
            genre: "Biography",
            rating: "PG-13",
            language: "EN",
            format: "Standard",
            audioFormat: "Dolby Digital",
            duration: "2h 12m",
            imageName: "michael",
            cinema: "AMC Grand",
            hall: "5th",
            date: "18.05.2025",
            time: "20:30",
            seats: "Row D (4,5,6,7)",
            ticketCount: 4,
            totalAmount: 48.50,
            currency: "USD"
        ),
        MovieTicket(
            movieTitle: "Pacific Rim",
            genre: "Sci-Fi",
            rating: "PG-13",
            language: "EN",
            format: "4DX",
            audioFormat: "Dolby Atmos",
            duration: "2h 11m",
            imageName: "pacific_rim",
            cinema: "IMAX Downtown",
            hall: "3rd",
            date: "21.05.2025",
            time: "19:00",
            seats: "Row B (8,9)",
            ticketCount: 2,
            totalAmount: 32.00,
            currency: "USD"
        ),
        MovieTicket(
            movieTitle: "Joker",
            genre: "Thriller",
            rating: "R",
            language: "EN",
            format: "ScreenX",
            audioFormat: "Dolby Atmos",
            duration: "2h 02m",
            imageName: "joker",
            cinema: "Cinema City",
            hall: "7th",
            date: "25.05.2025",
            time: "23:15",
            seats: "Row A (10)",
            ticketCount: 1,
            totalAmount: 14.99,
            currency: "USD"
        )
    ]
}
