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
    private let posterHeight: CGFloat = 420

    // Seeded with whatever summary-level data got us here (list cards only
    // carry title/poster/genre), then upgraded once the full TMDB detail
    // (cast, gallery, trailer, certification) loads.
    @State private var detail: Movie
    @State private var recommendations: [Movie] = []

    init(movie: Movie) {
        self.movie = movie
        _detail = State(initialValue: movie)
    }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    // Poster — stretches upward to cover pull-down overscroll instead of
                    // revealing the black background behind it, matching HomeView's hero.
                    GeometryReader { proxy in
                        let stretch = max(0, proxy.frame(in: .named("movieDetailScroll")).minY)

                        ZStack(alignment: .bottom) {
                            PosterCard(movie: detail)
                                .frame(width: proxy.size.width, height: posterHeight + stretch)
                                .clipped()
                                .frame(height: posterHeight, alignment: .bottom)
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
                    }
                    .frame(height: posterHeight)
                    // Details
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(detail.genre) • \(detail.rating) • \(detail.duration)")
                            .font(AppFont.medium.font(size: 14))
                            .foregroundStyle(.gray)
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    if detail.comingSoon {
                                        Image(.soonBadge)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 22, height: 22)
                                    }
                                    Text(detail.title)
                                        .font(AppFont.semiBold.font(size: 24))
                                        .foregroundStyle(.white)
                                }
                                HStack {
                                    MovieAgeRatingView(rating: detail.ageBadge, forgroundColor: .black, backgroundColor: .white)
                                    ForEach(detail.languageTags, id: \.self) { tag in
                                        MovieLanguageView(language: tag, accentColor: .white)
                                    }
                                }
                            }
                            Spacer()
                            HStack(spacing: 10) {
                                // Notify Button
                                if detail.comingSoon {
                                    Button {
                                      print("TODO: Notify")
                                    } label: {
                                        Image(systemName: "bell")
                                            .foregroundStyle(.white)
                                            .padding()
                                            .frame(width: 50, height: 50)
                                            .glassEffect(.clear)
                                            .clipShape(Circle())
                                    }
                                }
                                // Play Button
                                NavigationLink {
                                    VideoPlayerView(movie: detail)
                                } label: {
                                    Image(systemName: "play.fill")
                                        .foregroundStyle(.white)
                                        .padding()
                                        .frame(width: 50, height: 50)
                                        .glassEffect(.clear.tint(.red))
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    // Rating Section
                    HStack(alignment: .center) {
                        ratingView(provider: "IMBD", imageName: "imdb_rating", rating: detail.imdbRating)
                        Spacer()
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 1)
                            .padding(.vertical, 10)
                        Spacer()
                        ratingView(provider: "Rotten Tomatoes", imageName: "rottenTomatoes_rating", rating: detail.rottenTomatoesRating)
                        Spacer()
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 1)
                            .padding(.vertical, 10)
                        Spacer()
                        ratingView(provider: "CornPass", imageName: "cornpass_rating", rating: detail.cornPassRating)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 20)

                    // Movie Description
                    Text(detail.description)
                        .foregroundStyle(.gray)
                        .font(AppFont.regular.font(size: 16))
                        .padding(.horizontal)
                    // Screenshots
                    ScrollView(.horizontal) {
                        HStack {
                            if detail.gallery.isEmpty {
                                ForEach(0...3, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(.gray.opacity(0.3))
                                        .frame(width: 160, height: 100)
                                }
                            } else {
                                ForEach(detail.gallery, id: \.self) { url in
                                    RemoteImage(url: url)
                                        .frame(width: 160, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
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
                            ForEach(detail.director, id: \.self) { director in
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
                            ForEach(detail.writers, id: \.self) { writer in
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

                            ForEach(detail.stars, id: \.self) { star in
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
                                    rating: detail.rating,
                                    forgroundColor: .black,
                                    backgroundColor: .white
                                )
                                ForEach(detail.languageTags, id: \.self) { tag in
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
                        movies: recommendations,
                        cardWidth: 110,
                        cardHeight: 156,
                        showBadge: false
                    )
                    .padding(.vertical)
                }
            }
            .scrollIndicators(.hidden)
            .coordinateSpace(name: "movieDetailScroll")
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolbarIconButton(systemImage: "chevron.backward") {
                    dismiss()
                }
            }
        }
        .task(id: movie.id) {
            async let fullDetail = MovieRepository.shared.detail(for: movie.id)
            async let similar = MovieRepository.shared.similarMovies(to: movie.id)
            if let fullDetail = try? await fullDetail {
                detail = fullDetail.preservingComingSoon(from: movie)
            }
            recommendations = (try? await similar) ?? []
        }
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
