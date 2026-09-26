//
//  TMDBModels.swift
//  Cornpass
//
//  Raw Codable DTOs mirroring TMDB's JSON shapes. Kept separate from the
//  app's own `Movie` model so TMDB's schema can drift without touching UI code.
//
//  Explicitly `nonisolated` + `Sendable`: the project defaults new types to
//  @MainActor, but these are plain data crossing from the `MovieRepository`
//  actor to callers, so they must stay actor-agnostic.
//

import Foundation

nonisolated struct TMDBPagedResponse<T: Decodable & Sendable>: Decodable, Sendable {
    let page: Int
    let results: [T]
}

nonisolated struct TMDBMovieSummary: Decodable, Sendable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let genreIDs: [Int]
    let voteAverage: Double
    let originalLanguage: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
    }
}

nonisolated struct TMDBGenreList: Decodable, Sendable {
    let genres: [TMDBGenre]
}

nonisolated struct TMDBGenre: Decodable, Sendable {
    let id: Int
    let name: String
}

nonisolated struct TMDBMovieDetail: Decodable, Sendable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let runtime: Int?
    let genres: [TMDBGenre]
    let voteAverage: Double
    let originalLanguage: String
    let videos: TMDBVideoList?
    let credits: TMDBCredits?
    let releaseDates: TMDBReleaseDatesResponse?
    let images: TMDBImagesResponse?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case videos, credits
        case releaseDates = "release_dates"
        case images
    }
}

nonisolated struct TMDBVideoList: Decodable, Sendable {
    let results: [TMDBVideo]
}

nonisolated struct TMDBVideo: Decodable, Sendable {
    let key: String
    let site: String
    let type: String
    let official: Bool
}

nonisolated struct TMDBCredits: Decodable, Sendable {
    let cast: [TMDBCastMember]
    let crew: [TMDBCrewMember]
}

nonisolated struct TMDBCastMember: Decodable, Sendable {
    let name: String
    let order: Int
}

nonisolated struct TMDBCrewMember: Decodable, Sendable {
    let name: String
    let job: String
}

nonisolated struct TMDBReleaseDatesResponse: Decodable, Sendable {
    let results: [TMDBCountryReleaseDates]
}

nonisolated struct TMDBCountryReleaseDates: Decodable, Sendable {
    let iso31661: String
    let releaseDates: [TMDBReleaseDate]

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case releaseDates = "release_dates"
    }
}

nonisolated struct TMDBReleaseDate: Decodable, Sendable {
    let certification: String
}

nonisolated struct TMDBImagesResponse: Decodable, Sendable {
    let backdrops: [TMDBImageFile]
}

nonisolated struct TMDBImageFile: Decodable, Sendable {
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
