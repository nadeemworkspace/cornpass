//
//  SearchView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct SearchView: View {

    @State private var viewModel = SearchViewModel()
    @FocusState private var isFieldFocused: Bool

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 0) {
                searchBar
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .task(id: viewModel.trimmedQuery) {
            await viewModel.search(viewModel.trimmedQuery)
        }
    }

    // MARK: - Search bar

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white.opacity(0.7))
                .padding(.leading, 12)
            TextField("Search movies", text: $viewModel.query)
                .font(AppFont.regular.font(size: 16))
                .foregroundStyle(.white)
                .tint(.white)
                .focused($isFieldFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
            if !viewModel.query.isEmpty {
                Button {
                    viewModel.query = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.trailing, 12)
            }
        }
        .frame(height: 49)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#14181B"))
        .clipShape(Capsule())
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        if viewModel.trimmedQuery.isEmpty {
            ContentUnavailableView(
                "Search Movies",
                systemImage: "film.stack",
                description: Text("Find movies by title.")
            )
        } else if viewModel.isLoading && viewModel.results.isEmpty {
            ProgressView()
                .tint(.white)
        } else if viewModel.didFail {
            ContentUnavailableView(
                "Something Went Wrong",
                systemImage: "wifi.exclamationmark",
                description: Text("Couldn't load results. Try again.")
            )
        } else if viewModel.results.isEmpty {
            ContentUnavailableView.search(text: viewModel.trimmedQuery)
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.results) { result in
                        NavigationLink {
                            MovieDetailView(movie: result.movie)
                        } label: {
                            SearchResultRow(result: result)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .scrollDismissesKeyboard(.immediately)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
    .preferredColorScheme(.dark)
}
