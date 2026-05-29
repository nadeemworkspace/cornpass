//
//  MovieDetailView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 28/05/26.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @Environment(\.dismiss) private var dismiss
    private let grid = GridItem(.flexible(), alignment: .topLeading)
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    // Poster
                    ZStack(alignment: .bottom) {
                        PosterCard(movie: movie)
                            .frame(height: 400, alignment: .top)
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: .black.opacity(0.9), location: 0.9),
                                .init(color: .black, location: 1.0),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 180)
                    }
                    .clipped()
                    // Details
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(movie.genre) • \(movie.rating) • \(movie.duration)")
                            .font(AppFont.medium.font(size: 14))
                            .foregroundStyle(.gray)
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(movie.title)
                                    .font(AppFont.semiBold.font(size: 24))
                                    .foregroundStyle(.white)
                                HStack {
                                    MovieAgeRatingView(rating: movie.ageBadge, forgroundColor: .black, backgroundColor: .white)
                                    ForEach(movie.languageTags, id: \.self) { tag in
                                        MovieLanguageView(language: tag, accentColor: .white)
                                    }
                                }
                            }
                            Spacer()
                            // Play Button
                            NavigationLink {
                                VideoPlayerView(movie: movie)
                            } label: {
                                Image(systemName: "play.fill")
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(.gray.opacity(0.5))
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.horizontal)
                    // Rating Section
                    HStack(alignment: .center) {
                        ratingView(provider: "IMBD", imageName: "imdb_rating", rating: movie.imdbRating)
                        Spacer()
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 1)
                            .padding(.vertical, 10)
                        Spacer()
                        ratingView(provider: "Rotten Tomatoes", imageName: "rottenTomatoes_rating", rating: movie.rottenTomatoesRating)
                        Spacer()
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 1)
                            .padding(.vertical, 10)
                        Spacer()
                        ratingView(provider: "CornPass", imageName: "cornpass_rating", rating: movie.cornPassRating)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    
                    // Movie Description
                    Text(movie.description)
                        .foregroundStyle(.gray)
                        .font(AppFont.regular.font(size: 16))
                        .padding(.horizontal)
                    // Screenshots
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0...3, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(.gray.opacity(0.3))
                                    .frame(width: 160, height: 100)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.vertical, 20)
                    // Cast and Crew
                    LazyVGrid(columns: [grid, grid], alignment: .leading,spacing: 20) {
                        // Director
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Director")
                                .font(AppFont.medium.font(size: 10))
                                .foregroundStyle(.gray)
                            ForEach(movie.director, id: \.self) { director in
                                Text(director)
                                    .foregroundStyle(.white)
                                    .font(AppFont.regular.font(size: 14))
                            }
                        }
                        // Writers
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Writers")
                                .font(AppFont.medium.font(size: 10))
                                .foregroundStyle(.gray)
                            ForEach(movie.writers, id: \.self) { writer in
                                Text(writer)
                                    .foregroundStyle(.white)
                                    .font(AppFont.regular.font(size: 14))
                            }
                        }
                        // Stars
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Stars")
                                .font(AppFont.medium.font(size: 10))
                                .foregroundStyle(.gray)
                            
                            ForEach(movie.stars, id: \.self) { star in
                                Text(star)
                                    .foregroundStyle(.white)
                                    .font(AppFont.regular.font(size: 14))
                            }
                        }
                        // Classification
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Classification")
                                .font(AppFont.medium.font(size: 10))
                                .foregroundStyle(.gray)
                            HStack(spacing: 8) {
                                MovieAgeRatingView(
                                    rating: movie.rating,
                                    forgroundColor: .black,
                                    backgroundColor: .white
                                )
                                ForEach(movie.languageTags, id: \.self) { tag in
                                    MovieLanguageView(
                                        language: tag,
                                        accentColor: .white
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    // Recommendation
                    HorizontalMovieSection(
                        title: "You may also like",
                        movies: loadMovies()?.nowShowingMovies.filter { $0.id != movie.id } ?? [],
                        cardWidth: 110,
                        cardHeight: 156,
                        showBadge: false
                    )
                    .padding(.vertical)
                }
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .top)
        }
        .overlay(alignment: .top) {
            headerView
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private var headerView: some View {
        HStack {
            // Back Button
            ToolbarActionButton(image: "arrow_left") {
                dismiss()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func ratingView(provider: String, imageName: String, rating: String) -> some View {
        VStack(alignment: .center) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 20)
                Text(rating)
                    .foregroundStyle(.white)
                    .font(AppFont.medium.font(size: 14))
            }
            Text(provider)
                .foregroundStyle(.gray)
                .font(AppFont.medium.font(size: 12))
        }
    }
    
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: Movie.dummy)
    }
}
