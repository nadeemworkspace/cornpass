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
        .navigationTitle("Search movies")
        .navigationBarTitleDisplayMode(.inline)
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
        .glassEffect(.regular, in: .capsule)
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        if viewModel.trimmedQuery.isEmpty {
            initialStateView
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
    
    @ViewBuilder
    private var initialStateView: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: proxy.size.height * 0.2)
                Image(.searchIllustration)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 220)
                    .padding(.bottom, 24)
                Text("What are you in the mood for?")
                    .font(AppFont.bold.font(size: 22))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                Text("Search for a movie, actor, or genre and discover your next favorite.")
                    .font(AppFont.regular.font(size: 15))
                    .foregroundStyle(.white.opacity(0.65))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 5)
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
    .preferredColorScheme(.dark)
}
