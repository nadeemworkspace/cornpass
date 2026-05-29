//
//  Movie.swift
//  Cornpass
//
//  Created by muhammed.nadeem.m.a on 27/05/26.
//

import SwiftUI

struct MovieResponse: Codable {
    let heroMovies: [Movie]
    let nowShowingMovies: [Movie]
    let comingSoonMovies: [Movie]
    let animationMovies: [Movie]
}

struct Movie: Identifiable, Codable {
    let id: String
    let title: String
    let badge: String
    let genre: String
    let rating: String
    let duration: String
    let image: String
    let videoURL: String
    // Extra UI Data
    let description: String
    let ageBadge: String
    let languageTags: [String]
    // Ratings
    let imdbRating: String
    let rottenTomatoesRating: String
    let cornPassRating: String
    // Other
    let gallery: [String]
    let director: [String]
    let writers: [String]
    let stars: [String]
    let classification: String
}

extension Movie {
    static let dummy = Movie(
        id: "1",
        title: "Alien: Romulus",
        badge: "HOT",
        genre: "Sci-Fi",
        rating: "R",
        duration: "1h 56m",
        image: "alien_home",
        videoURL: "https://www.youtube.com/watch?v=OzY2r2JXsDM",
        description: "Young space colonizers come face to face with the most terrifying life-form in the universe.",
        ageBadge: "+18",
        languageTags: ["EN", "Sub EN/FR"],
        imdbRating: "8.1/10",
        rottenTomatoesRating: "81%",
        cornPassRating: "8.4/10",
        gallery: ["alien_scene_1", "alien_scene_2"],
        director: ["Fede Álvarez"],
        writers: ["Fede Álvarez", "Rodo Sayagues"],
        stars: ["Cailee Spaeny", "David Jonsson", "Archie Renaux"],
        classification: "R"
    )
}

func loadMovies() -> MovieResponse? {
    guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
        print("ERROR: JSON NOT FOUND IN BUNDLE")
        return nil
    }
    do {
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
        print("DECODE SUCCESSFULL")
        return decoded
    } catch {
        print("ERROR DECODING JSON: \(error.localizedDescription)")
        return nil
    }
}
