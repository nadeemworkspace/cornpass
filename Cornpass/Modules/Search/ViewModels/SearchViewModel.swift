//
//  SearchViewModel.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import Foundation
import Observation

@Observable
class SearchViewModel {

    var query: String = ""
    var results: [MovieSearchResult] = []
    var isLoading: Bool = false
    var didFail: Bool = false

    var trimmedQuery: String {
        query.trimmed
    }

    // Called from `.task(id: trimmedQuery)`, so every keystroke cancels the
    // previous call; the sleep debounces so only the query the user pauses on
    // hits the network.
    func search(_ text: String) async {
        guard !text.isEmpty else {
            results = []
            didFail = false
            isLoading = false
            return
        }
        isLoading = true
        do {
            try await Task.sleep(for: .milliseconds(350))
            let found = try await MovieRepository.shared.search(text)
            results = found
            didFail = false
            isLoading = false
        } catch is CancellationError {
            // Superseded by a newer query; that task owns the state now.
        } catch {
            if Task.isCancelled { return }
            results = []
            didFail = true
            isLoading = false
        }
    }
}
