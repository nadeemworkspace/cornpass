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
    let comingSoon: Bool
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
        classification: "R",
        comingSoon: false
    )
}

struct FeaturedMovie {
    let title: String
    let duration: String
    let tag: String
    let type: String
    let imdbRating: String
    let rating: String
    let languageTag: String
    let artName: String
}

extension FeaturedMovie {

    static let featured = featuredMovies.randomElement() ?? featuredMovies[0]

    private static let featuredMovies: [FeaturedMovie] = [
        .init(
            title: "Luca",
            duration: "1h 35m",
            tag: "Pixar",
            type: "Animation, Fantasy",
            imdbRating: "7.4/10",
            rating: "PG",
            languageTag: "EN",
            artName: "featured_luca"
        ),
        .init(
            title: "Tron: Ares",
            duration: "2h 8m",
            tag: "Neon",
            type: "Sci-Fi, Action",
            imdbRating: "7.3/10",
            rating: "UA",
            languageTag: "EN",
            artName: "featured_tron"
        ),
        .init(
            title: "Kong",
            duration: "1h 58m",
            tag: "Monsterverse",
            type: "Adventure",
            imdbRating: "6.7/10",
            rating: "UA",
            languageTag: "EN",
            artName: "featured_kong"
        )
    ]
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
