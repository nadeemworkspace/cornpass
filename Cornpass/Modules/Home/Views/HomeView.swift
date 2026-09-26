//
//  HomeView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 26/05/26.
//

import SwiftUI

struct HomeView: View {

    @State private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            if let movies = viewModel.movies {
                ScrollView {
                    VStack(spacing: 0) {
                        // Poster
                        if !movies.heroMovies.isEmpty {
                            HeroBannerSection(
                                movies: movies.heroMovies,
                                heroIndex: $viewModel.currentPosterIndex
                            )
                        }
                        // Sections
                        VStack(spacing: 28) {
                            // Now Showing
                            HorizontalMovieSection(
                                title: "Now Showing",
                                movies: movies.nowShowingMovies,
                                cardWidth: 160,
                                cardHeight: 220,
                                showBadge: false
                            )
                            // Coming soon
                            ComingSoonSection(
                                movies: movies.comingSoonMovies
                            )
                            // Genre
                            GenreSection(
                                genres: viewModel.genres
                            )
                            // Featured Movie
                            if let featuredMovie = viewModel.featuredMovie {
                                FeaturedMovieView(movie: featuredMovie)
                            }
                            // Animated Movies
                            HorizontalMovieSection(
                                title: "Animation",
                                movies: movies.animationMovies,
                                cardWidth: 140,
                                cardHeight: 200,
                                showBadge: false
                            )
                            // Branding
                            brandingView
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
                .scrollIndicators(.hidden)
                .coordinateSpace(name: "homeScroll")
            } else if let loadError = viewModel.loadError {
                VStack(spacing: 12) {
                    Text(loadError)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Button("Retry") {
                        Task { await viewModel.load() }
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(.white)
                    .clipShape(Capsule())
                }
            } else {
                ProgressView()
                    .tint(.white)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.load()
        }
    }
}

extension HomeView {
    
    @ViewBuilder
    private var brandingView: some View {
        VStack(spacing: 5) {
            Text("made with love ♥️")
                .foregroundStyle(.white)
                .font(AppFont.semiBold.font(size: 12))
            Image(.logoWhite)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        }
        .opacity(0.6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
}

#Preview {
    HomeView()
}
