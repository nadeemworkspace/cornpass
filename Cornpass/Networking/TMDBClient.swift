//
//  TMDBClient.swift
//  Cornpass
//
//  Thin async/await wrapper over TMDB's v3 REST API, authenticated with the
//  v4 read access token (Bearer header works against all v3 endpoints too).
//
//  Explicitly `nonisolated` + `Sendable`: the project defaults new types to
//  @MainActor, but this is called from the `MovieRepository` actor, so it
//  must stay actor-agnostic.
//

import Foundation

nonisolated enum TMDBError: Error, Sendable {
    case invalidURL
    case requestFailed(Int)
}

nonisolated struct TMDBClient: Sendable {

    static let shared = TMDBClient()

    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func get<T: Decodable & Sendable>(_ path: String, query: [String: String] = [:]) async throws -> T {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            throw TMDBError.invalidURL
        }
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = components.url else { throw TMDBError.invalidURL }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(Secrets.tmdbAccessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")

        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw TMDBError.requestFailed(code)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

// Full-size image URLs from TMDB's CDN. https://developer.themoviedb.org/docs/image-basics
nonisolated enum TMDBImage {
    private static let base = "https://image.tmdb.org/t/p/"

    static func poster(_ path: String?, size: String = "w500") -> URL? {
        url(path, size: size)
    }

    static func backdrop(_ path: String?, size: String = "w1280") -> URL? {
        url(path, size: size)
    }

    private static func url(_ path: String?, size: String) -> URL? {
        guard let path, !path.isEmpty else { return nil }
        return URL(string: base + size + path)
    }
}
