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
                    // Poster
                    HeroBannerSection(
                        heroIndex: $currentPosterIndex
                    )
                    // Sections
                    VStack(spacing: 28) {
                        // Now Showing
                        HorizontalMovieSection(
                            title: "Now Showing",
                            movies: nowShowingMovies,
                            cardWidth: 160,
                            cardHeight: 220,
                            showBadge: false
                        )
                        // Coming soon
                        ComingSoonSection(
                            movies: comingSoonMovies
                        )
                        // Genre
                        GenreSection(
                            genres: Genre.all
                        )
                        // Featured Movie
                        FeaturedMovieView()
                        // Animated Movies
                        HorizontalMovieSection(
                            title: "Animation",
                            movies: animationMovies,
                            cardWidth: 140,
                            cardHeight: 200,
                            showBadge: false
                        )
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea(edges: .top)
    }
}

//#Preview {
//    HomeView()
//}

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
            .frame(height: 540)
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
            .frame(height: 200)
            .allowsHitTesting(false)

            // Info + Controls
            VStack(spacing: 8) {
                // Movie badge + title
                Group {
                    HStack(spacing: 6) {
                        Image(.soonBadge)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                        Text(heroMovies[heroIndex].title)
                            .font(AppFont.semiBold.font(size: 24))

                    }

                    Text("\(heroMovies[heroIndex].badge) • \(heroMovies[heroIndex].genre) • \(heroMovies[heroIndex].rating) • \(heroMovies[heroIndex].duration)")
                        .font(AppFont.medium.font(size: 14))
                }
                .foregroundColor(.white)
                .animation(.smooth, value: heroIndex)

                // Page Control
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
                    CircleIconButton(icon: "plus") {
                        print("TODO: Add to watchlist")
                    }
                    TrailerButton()
                    CircleIconButton(icon: "info") {
                        print("TODO: Info")
                    }
                }
                .padding(.top, 6)
            }
            .padding(.bottom, 20)
        }
        .frame(height: 540)
        .clipped()
    }
}

struct PosterCard: View {
    let movie: Movie
    var body: some View {
        ZStack {
            Image(movie.image)
                .resizable()
                .scaledToFill()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CircleIconButton: View {
    let icon: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
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
        Button {
            print("TODO: Play triler")
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "play.fill")
                    .font(.system(size: 13))
                Text("Trailer")
                    .font(AppFont.medium.font(size: 18))
            }
            .foregroundColor(.black)
            .padding(.horizontal, 22)
            .frame(height: 42)
            .background(Color.white)
            .clipShape(Capsule())
        }
    }
}

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
        .padding(.horizontal)
    }
}

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
                        MovieCard(
                            movie: movie,
                            width: cardWidth,
                            height: cardHeight,
                            showBadge: showBadge
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct MovieCard: View {
    let movie: Movie
    let width: CGFloat
    let height: CGFloat
    let showBadge: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(movie.image)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
            if showBadge {
                BadgeView(text: movie.badge)
                    .padding(8)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

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
                .padding(.horizontal)
            }
        }
    }
}

struct ComingSoonCard: View {
    let movie: Movie

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(movie.image)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 150)
            HStack {
                Image(.soonBadge)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                Spacer()
            }
            .padding(10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
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

struct GenreSection: View {
    let genres: [Genre]
    @State private var selectedGenres: Set<String> = []
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
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(genres) { genre in
                        genreChip(genre: genre)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    func genreChip(genre: Genre) -> some View {
        Text(genre.name)
            .foregroundStyle(selectedGenres.contains(genre.name) ? .black : .white)
            .font(AppFont.medium.font(size: 16))
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(selectedGenres.contains(genre.name) ? .white : Color(hex: "#14181B"))
            .clipShape(Capsule())
            .onTapGesture {
                if selectedGenres.contains(genre.name) {
                    selectedGenres.remove(genre.name)
                } else {
                    selectedGenres.insert(genre.name)
                }
            }
            .animation(.spring, value: selectedGenres)
    }
}

struct FeaturedMovieView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(.featuredLuca)
                .resizable()
                .scaledToFit()
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("NEW • Animation • 1h 49m")
                        .font(AppFont.regular.font(size: 10))
                    HStack {
                        Text("Loca")
                            .font(AppFont.semiBold.font(size: 24))
                        HStack(alignment: .center, spacing: 5) {
                            Image(.toppick)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                            Text("Our Pick")
                                .foregroundStyle(.black)
                                .font(AppFont.semiBold.font(size: 10))
                        }
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    HStack(alignment: .center) {
                        Text("8.9")
                            .font(AppFont.bold.font(size: 12))
                        Image(.imdb)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 10)
                    }
                    // Rating - Language
                    HStack(alignment: .center) {
                        MovieAgeRatingView(rating: "PG13+", forgroundColor: .black, backgroundColor: .white)
                        MovieLanguageView(language: "EN", accentColor: .white)
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(
                VariableBlurView(
                    maxBlurRadius: 10,
                    direction: .blurredBottomClearTop,
                    startOffset: 10
                )
            )
        }
        .clipShape(.rect(cornerRadius: 14))
        .padding(.horizontal)
    }
}

#Preview {
    FeaturedMovieView()
}
