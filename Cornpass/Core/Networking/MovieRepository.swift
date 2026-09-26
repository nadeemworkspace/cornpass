//
//  MovieRepository.swift
//  Cornpass
//
//  Fetches TMDB data and maps it onto the app's own `Movie`/`Genre` models,
//  filling in the fields TMDB doesn't provide (badge, CornPass rating, ...)
//  with reasonable defaults derived from what it does provide.
//

import Foundation

actor MovieRepository {

    static let shared = MovieRepository()

    private let client: TMDBClient
    private var genreMap: [Int: String] = [:]

    init(client: TMDBClient = .shared) {
        self.client = client
    }

    // MARK: - Public

    func homeFeed() async throws -> MovieResponse {
        try await loadGenresIfNeeded()

        async let trending: TMDBPagedResponse<TMDBMovieSummary> = client.get("trending/movie/day")
        async let nowPlaying: TMDBPagedResponse<TMDBMovieSummary> = client.get("movie/now_playing")
        async let upcoming: TMDBPagedResponse<TMDBMovieSummary> = client.get("movie/upcoming")
        async let animation: TMDBPagedResponse<TMDBMovieSummary> = client.get(
            "discover/movie",
            query: ["with_genres": "16", "sort_by": "popularity.desc"]
        )

        let heroSummaries = Array(try await trending.results.prefix(5))
        let nowShowing = try await nowPlaying.results
        let comingSoon = try await upcoming.results
        let animated = try await animation.results

        // The hero banner shows duration/certification inline, which only the
        // per-movie detail endpoint has, so resolve full detail for just those few.
        let heroMovies = try await withThrowingTaskGroup(of: (Int, Movie).self) { group in
            for (index, summary) in heroSummaries.enumerated() {
                group.addTask { (index, try await self.detail(for: summary.id)) }
            }
            var slots = [Movie?](repeating: nil, count: heroSummaries.count)
            for try await (index, movie) in group { slots[index] = movie }
            return slots.compactMap { $0 }
        }

        return MovieResponse(
            heroMovies: heroMovies,
            nowShowingMovies: nowShowing.map { mapSummary($0) },
            comingSoonMovies: comingSoon.map { mapSummary($0, forceComingSoon: true) },
            animationMovies: animated.map { mapSummary($0) }
        )
    }

    // Pulled from TMDB's top-rated list rather than the endpoints already
    // used elsewhere on Home (trending, now_playing, upcoming, discover), so
    // the "Our Pick" card shows a genuinely different, critically-acclaimed
    // set of movies instead of overlapping with them.
    //
    // Fetches full detail (not just summary) for the first `count` movies,
    // so the featured card can show real duration/certification — same
    // reason `homeFeed()` does this for the hero banner.
    func featuredMovies(count: Int = 5) async throws -> [Movie] {
        let topRated: TMDBPagedResponse<TMDBMovieSummary> = try await client.get("movie/top_rated")
        let picks = Array(topRated.results.prefix(count))
        guard !picks.isEmpty else {
            throw TMDBError.requestFailed(-1)
        }
        return try await withThrowingTaskGroup(of: (Int, Movie).self) { group in
            for (index, summary) in picks.enumerated() {
                group.addTask { (index, try await self.detail(for: summary.id)) }
            }
            var slots = [Movie?](repeating: nil, count: picks.count)
            for try await (index, movie) in group { slots[index] = movie }
            return slots.compactMap { $0 }
        }
    }

    func detail(for id: Int) async throws -> Movie {
        try await loadGenresIfNeeded()
        let detail: TMDBMovieDetail = try await client.get(
            "movie/\(id)",
            query: ["append_to_response": "videos,credits,release_dates,images"]
        )
        return mapDetail(detail)
    }

    func similarMovies(to id: Int) async throws -> [Movie] {
        let page: TMDBPagedResponse<TMDBMovieSummary> = try await client.get("movie/\(id)/recommendations")
        return page.results.map { mapSummary($0) }
    }

    func search(_ query: String) async throws -> [MovieSearchResult] {
        try await loadGenresIfNeeded()
        let page: TMDBPagedResponse<TMDBMovieSummary> = try await client.get(
            "search/movie",
            query: ["query": query, "include_adult": "false"]
        )
        return page.results.map { summary in
            MovieSearchResult(
                movie: mapSummary(summary),
                genres: summary.genreIDs.compactMap { genreMap[$0] },
                releaseDate: Self.parseDate(summary.releaseDate)
            )
        }
    }

    func genres() async throws -> [Genre] {
        try await loadGenresIfNeeded()
        return genreMap
            .sorted { $0.key < $1.key }
            .map { Genre(name: $0.value, emoji: Self.emoji(for: $0.value)) }
    }

    // MARK: - Genre cache

    private func loadGenresIfNeeded() async throws {
        guard genreMap.isEmpty else { return }
        let list: TMDBGenreList = try await client.get("genre/movie/list")
        genreMap = Dictionary(uniqueKeysWithValues: list.genres.map { ($0.id, $0.name) })
    }

    // MARK: - Mapping

    private func mapSummary(_ summary: TMDBMovieSummary, forceComingSoon: Bool = false) -> Movie {
        Movie(
            id: summary.id,
            title: summary.title,
            badge: Self.badge(voteAverage: summary.voteAverage, releaseDate: summary.releaseDate),
            genre: summary.genreIDs.first.flatMap { genreMap[$0] } ?? "Movie",
            rating: "NR",
            duration: "--",
            posterURL: TMDBImage.poster(summary.posterPath),
            backdropURL: TMDBImage.backdrop(summary.backdropPath),
            videoURL: "",
            description: summary.overview,
            ageBadge: "NR",
            languageTags: [summary.originalLanguage.uppercased()],
            imdbRating: Self.formatRating(summary.voteAverage),
            rottenTomatoesRating: Self.formatPercent(summary.voteAverage),
            cornPassRating: Self.formatRating(summary.voteAverage),
            gallery: [],
            director: [],
            writers: [],
            stars: [],
            classification: "NR",
            comingSoon: forceComingSoon || Self.isFutureRelease(summary.releaseDate)
        )
    }

    private func mapDetail(_ detail: TMDBMovieDetail) -> Movie {
        let director = detail.credits?.crew.filter { $0.job == "Director" }.map(\.name) ?? []
        let writers = Self.dedupe(
            detail.credits?.crew.filter { ["Screenplay", "Writer", "Story"].contains($0.job) }.map(\.name) ?? []
        )
        let stars = (detail.credits?.cast ?? [])
            .sorted { $0.order < $1.order }
            .prefix(5)
            .map(\.name)
        let certification = detail.releaseDates?.results
            .first { $0.iso31661 == "US" }?
            .releaseDates
            .first { !$0.certification.isEmpty }?
            .certification
        let trailerKey = detail.videos?.results.first { $0.site == "YouTube" && $0.type == "Trailer" }?.key
            ?? detail.videos?.results.first { $0.site == "YouTube" }?.key
        let gallery = (detail.images?.backdrops ?? [])
            .prefix(8)
            .compactMap { TMDBImage.backdrop($0.filePath) }

        return Movie(
            id: detail.id,
            title: detail.title,
            badge: Self.badge(voteAverage: detail.voteAverage, releaseDate: detail.releaseDate),
            genre: detail.genres.first?.name ?? "Movie",
            rating: certification ?? "NR",
            duration: Self.formatRuntime(detail.runtime),
            posterURL: TMDBImage.poster(detail.posterPath),
            backdropURL: TMDBImage.backdrop(detail.backdropPath),
            videoURL: trailerKey.map { "https://www.youtube.com/watch?v=\($0)" } ?? "",
            description: detail.overview,
            ageBadge: certification ?? "NR",
            languageTags: [detail.originalLanguage.uppercased()],
            imdbRating: Self.formatRating(detail.voteAverage),
            rottenTomatoesRating: Self.formatPercent(detail.voteAverage),
            cornPassRating: Self.formatRating(detail.voteAverage),
            gallery: Array(gallery),
            director: director,
            writers: writers,
            stars: Array(stars),
            classification: certification ?? "NR",
            comingSoon: Self.isFutureRelease(detail.releaseDate)
        )
    }

    // MARK: - Small formatting helpers

    private static func formatRuntime(_ minutes: Int?) -> String {
        guard let minutes, minutes > 0 else { return "--" }
        return "\(minutes / 60)h \(minutes % 60)m"
    }

    private static func formatRating(_ voteAverage: Double) -> String {
        String(format: "%.1f/10", voteAverage)
    }

    private static func formatPercent(_ voteAverage: Double) -> String {
        "\(Int((voteAverage * 10).rounded()))%"
    }

    private static func badge(voteAverage: Double, releaseDate: String?) -> String {
        if isFutureRelease(releaseDate) { return "SOON" }
        if let days = daysSinceRelease(releaseDate), days <= 60 { return "NEW" }
        if voteAverage >= 7.5 { return "HOT" }
        return "POPULAR"
    }

    private static func isFutureRelease(_ releaseDate: String?) -> Bool {
        guard let date = parseDate(releaseDate) else { return false }
        return date > Date()
    }

    private static func daysSinceRelease(_ releaseDate: String?) -> Int? {
        guard let date = parseDate(releaseDate) else { return nil }
        return Calendar.current.dateComponents([.day], from: date, to: Date()).day
    }

    private static func parseDate(_ string: String?) -> Date? {
        guard let string, !string.isEmpty else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.date(from: string)
    }

    private static func dedupe(_ names: [String]) -> [String] {
        var seen = Set<String>()
        return names.filter { seen.insert($0).inserted }
    }

    private static func emoji(for genreName: String) -> String {
        switch genreName {
        case "Action": return "💣"
        case "Adventure": return "🗺️"
        case "Animation": return "🧸"
        case "Comedy": return "🤣"
        case "Crime": return "🕵️"
        case "Documentary": return "🎥"
        case "Drama": return "😢"
        case "Family": return "👨‍👩‍👧"
        case "Fantasy": return "🦄"
        case "History": return "📙"
        case "Horror": return "🎃"
        case "Music": return "🎵"
        case "Mystery": return "🔍"
        case "Romance": return "💕"
        case "Science Fiction": return "🌏"
        case "TV Movie": return "📺"
        case "Thriller": return "🔪"
        case "War": return "⚔️"
        case "Western": return "🤠"
        default: return "🎬"
        }
    }
}
