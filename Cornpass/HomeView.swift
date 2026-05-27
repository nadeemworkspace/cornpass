//
//  HomeView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 26/05/26.
//

import SwiftUI

struct HomeView: View {
    @State private var currentPosterIndex: Int = 0
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // POster
                    HeroBannerSection(heroIndex: $currentPosterIndex)
                    // Sections
                    VStack(spacing: 28) {
                        HorizontalMovieSection(title: "Now Showing", movies: nowShowingMovies, cardWidth: 160, cardHeight: 220, showBadge: false)
                        ComingSoonSection(movies: comingSoonMovies)
                        GenreSection(genres: genres)
                        FeaturedPickSection()
                        HorizontalMovieSection(title: "Animation", movies: animationMovies, cardWidth: 140, cardHeight: 200, showBadge: false)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    HomeView()
}

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let badge: String
    let genre: String
    let rating: String
    let duration: String
    let color: Color
}

struct Genre1: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
}

let heroMovies: [Movie] = [
    Movie(title: "Arrival", badge: "NEW", genre: "Mystery", rating: "PG-13", duration: "1h 56m", color: Color(red: 0.25, green: 0.30, blue: 0.38)),
    Movie(title: "Dune: Part Two", badge: "NEW", genre: "Sci-Fi", rating: "PG-13", duration: "2h 46m", color: Color(red: 0.42, green: 0.30, blue: 0.18)),
    Movie(title: "Oppenheimer", badge: "HOT", genre: "Drama", rating: "R", duration: "3h 0m", color: Color(red: 0.15, green: 0.15, blue: 0.20)),
]

let nowShowingMovies: [Movie] = [
    Movie(title: "Peaky Blinders", badge: "", genre: "Crime", rating: "TV-MA", duration: "1h 0m", color: Color(red: 0.50, green: 0.38, blue: 0.20)),
    Movie(title: "Avatar 2", badge: "", genre: "Action", rating: "PG-13", duration: "3h 12m", color: Color(red: 0.08, green: 0.28, blue: 0.45)),
    Movie(title: "Interstellar", badge: "", genre: "Sci-Fi", rating: "PG-13", duration: "2h 49m", color: Color(red: 0.10, green: 0.12, blue: 0.22)),
]

let comingSoonMovies: [Movie] = [
    Movie(title: "Minions 3", badge: "SO ON", genre: "Animation", rating: "PG", duration: "1h 30m", color: Color(red: 0.90, green: 0.72, blue: 0.10)),
    Movie(title: "Napoleon", badge: "SO ON", genre: "History", rating: "R", duration: "2h 38m", color: Color(red: 0.35, green: 0.22, blue: 0.15)),
    Movie(title: "Gladiator II", badge: "SO ON", genre: "Action", rating: "R", duration: "2h 28m", color: Color(red: 0.40, green: 0.28, blue: 0.18)),
    Movie(title: "Furiosa", badge: "SO ON", genre: "Action", rating: "R", duration: "2h 28m", color: Color(red: 0.55, green: 0.18, blue: 0.12)),
]

let genres: [Genre1] = [
    Genre1(icon: "🗺️", name: "Adventure"),
    Genre1(icon: "😄", name: "Comedy"),
    Genre1(icon: "💕", name: "Romance"),
    Genre1(icon: "🔪", name: "Thriller"),
    Genre1(icon: "👻", name: "Horror"),
]

let animationMovies: [Movie] = [
    Movie(title: "Penguins", badge: "", genre: "Animation", rating: "PG", duration: "1h 32m", color: Color(red: 0.10, green: 0.22, blue: 0.40)),
    Movie(title: "Lion King", badge: "", genre: "Animation", rating: "G", duration: "1h 28m", color: Color(red: 0.60, green: 0.38, blue: 0.08)),
    Movie(title: "Brave", badge: "", genre: "Animation", rating: "PG", duration: "1h 33m", color: Color(red: 0.20, green: 0.35, blue: 0.22)),
]

// MARK: - Main View

struct CinemaHomeView: View {
    @State private var heroIndex = 0

    var body: some View {
    }
}

// MARK: - Hero Banner

struct HeroBannerSection: View {
    @Binding var heroIndex: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            // Pager
            TabView(selection: $heroIndex) {
                ForEach(heroMovies.indices, id: \.self) { index in
                    PosterCard(movie: heroMovies[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 480)
            // Dark gradient overlay
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0.0),
                    .init(color: .black.opacity(0.9), location: 0.9),
                    .init(color: .black, location: 1.0),
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 190)
            .allowsHitTesting(false)

            // Info + Controls
            VStack(spacing: 8) {
                // Movie badge + title
                HStack(spacing: 6) {
                    Image(systemName: "square.grid.2x2.fill")
                        .font(.system(size: 11))
                        .foregroundColor(.white)
                    Text(heroMovies[heroIndex].title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                }

                Text("\(heroMovies[heroIndex].badge) · \(heroMovies[heroIndex].genre) · \(heroMovies[heroIndex].rating) · \(heroMovies[heroIndex].duration)")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.65))

                // Page dots
                HStack(spacing: 5) {
                    ForEach(heroMovies.indices, id: \.self) { i in
                        Capsule()
                            .fill(i == heroIndex ? Color.white : Color.white.opacity(0.35))
                            .frame(width: i == heroIndex ? 18 : 6, height: 6)
                            .animation(.spring(response: 0.3), value: heroIndex)
                    }
                }
                .padding(.top, 2)

                // Action buttons
                HStack(spacing: 16) {
                    CircleIconButton(icon: "plus")
                    TrailerButton()
                    CircleIconButton(icon: "info")
                }
                .padding(.top, 6)
            }
            .padding(.bottom, 20)
        }
        .frame(height: 480)
        .clipped()
    }
}

struct PosterCard: View {
    let movie: Movie

    var body: some View {
        ZStack {
            Image(.oppenheimer)
                .resizable()
                .scaledToFill()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CircleIconButton: View {
    let icon: String

    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 42, height: 42)
                .background(Color.white.opacity(0.15))
                .clipShape(Circle())
        }
    }
}

struct TrailerButton: View {
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 6) {
                Image(systemName: "play.fill")
                    .font(.system(size: 13))
                Text("Trailer")
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundColor(.black)
            .padding(.horizontal, 22)
            .frame(height: 42)
            .background(Color.white)
            .clipShape(Capsule())
        }
    }
}

// MARK: - Section Header

struct SectionHeader: View {
    let title: String
    let actionLabel: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Button(action: {}) {
                HStack(spacing: 2) {
                    Text(actionLabel)
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.55))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11))
                        .foregroundColor(.white.opacity(0.55))
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Horizontal Movie Section (Now Showing / Animation)

struct HorizontalMovieSection: View {
    let title: String
    let movies: [Movie]
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    let showBadge: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: title, actionLabel: "More")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(movies) { movie in
                        SkeletonMovieCard(movie: movie, width: cardWidth, height: cardHeight, showBadge: showBadge)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct SkeletonMovieCard: View {
    let movie: Movie
    let width: CGFloat
    let height: CGFloat
    let showBadge: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [movie.color, movie.color.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: width, height: height)
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 28))
                        .foregroundColor(.white.opacity(0.08))
                )

            if showBadge {
                BadgeView(text: movie.badge)
                    .padding(8)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Coming Soon Section

struct ComingSoonSection: View {
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Coming Soon", actionLabel: "More")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(movies) { movie in
                        ComingSoonCard(movie: movie)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct ComingSoonCard: View {
    let movie: Movie

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    LinearGradient(
                        colors: [movie.color, movie.color.opacity(0.5)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 110, height: 150)
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 22))
                        .foregroundColor(.white.opacity(0.08))
                )

            // Badge bottom-left
            HStack {
                BadgeView(text: movie.badge)
                Spacer()
            }
            .padding(6)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct BadgeView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 9, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 3)
            .background(Color(red: 0.20, green: 0.20, blue: 0.28))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

// MARK: - Genre Section

struct GenreSection: View {
    let genres: [Genre1]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Genres")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Button(action: {}) {
                    Text("All >")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.55))
                }
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(genres) { genre in
                        GenreChip(genre: genre)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct GenreChip: View {
    let genre: Genre1

    var body: some View {
        HStack(spacing: 5) {
            Text(genre.icon)
                .font(.system(size: 14))
            Text(genre.name)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color(red: 0.15, green: 0.15, blue: 0.20))
        .clipShape(Capsule())
    }
}

// MARK: - Featured Pick Section (Luca-style card)

struct FeaturedPickSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                // Large skeleton card
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.20, green: 0.45, blue: 0.65),
                                Color(red: 0.10, green: 0.60, blue: 0.50),
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "film.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white.opacity(0.06))
                    )

                // Bottom info overlay
                LinearGradient(
                    colors: [.clear, .black.opacity(0.75)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))

                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("NEW · Animation · 1h 49m")
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.7))
                        HStack(spacing: 4) {
                            Text("Loca")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                            Label("Our Pick", systemImage: "hand.thumbsup.fill")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 7)
                                .padding(.vertical, 3)
                                .background(Color(red: 0.15, green: 0.55, blue: 0.40))
                                .clipShape(Capsule())
                        }
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 3) {
                        HStack(spacing: 2) {
                            Text("8.9/10")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                            Text("IMDb")
                                .font(.system(size: 9, weight: .semibold))
                                .foregroundColor(Color(red: 0.95, green: 0.72, blue: 0.10))
                        }
                        Text("EN")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                .padding(14)
            }
        }
        .padding(.horizontal, 16)
    }
}
