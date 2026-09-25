//
//  HomeView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 26/05/26.
//

import SwiftUI

@Observable
class HomeViewModel {

    var movies: MovieResponse?
    var featuredMovie: Movie?
    var genres: [Genre] = Genre.fallback
    var currentPosterIndex: Int = 0
    var isLoading = false
    var loadError: String?

    func load() async {
        guard movies == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            async let feed = MovieRepository.shared.homeFeed()
            async let featured = MovieRepository.shared.featuredMovie()
            async let fetchedGenres = MovieRepository.shared.genres()

            movies = try await feed
            featuredMovie = try? await featured
            if let fetchedGenres = try? await fetchedGenres, !fetchedGenres.isEmpty {
                genres = fetchedGenres
            }
            loadError = nil
        } catch {
            loadError = "Couldn't load movies. Check your connection and try again."
        }
    }
}

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

struct HeroBannerSection: View {
    let movies: [Movie]
    @Binding var heroIndex: Int

    private let heroHeight: CGFloat = 540

    var body: some View {
        GeometryReader { proxy in
            // Overscroll past the top (pull-down) is positive; scrolling down is negative/zero.
            let stretch = max(0, proxy.frame(in: .named("homeScroll")).minY)

            ZStack(alignment: .bottom) {
                TabView(selection: $heroIndex) {
                    ForEach(movies.indices, id: \.self) { index in
                        PosterCard(movie: movies[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(width: proxy.size.width, height: heroHeight + stretch)
                .clipped()
                .frame(height: heroHeight, alignment: .bottom)
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
                            if movies[heroIndex].comingSoon {
                                Image(.soonBadge)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22, height: 22)
                            }
                            Text(movies[heroIndex].title)
                                .font(AppFont.semiBold.font(size: 24))
                        }
                        Text("\(movies[heroIndex].badge) • \(movies[heroIndex].genre) • \(movies[heroIndex].rating) • \(movies[heroIndex].duration)")
                            .font(AppFont.medium.font(size: 14))
                    }
                    .foregroundColor(.white)
                    .animation(.smooth, value: heroIndex)

                    // Page Control
                    HStack(spacing: 5) {
                        ForEach(movies.indices, id: \.self) { i in
                            Capsule()
                                .fill(i == heroIndex ? Color.white : Color.white.opacity(0.35))
                                .frame(width: i == heroIndex ? 18 : 6, height: 6)
                                .animation(.spring(response: 0.3), value: heroIndex)
                        }
                    }
                    .padding(.top, 2)

                    // Action buttons
                    HStack(spacing: 16) {
                        Button {
                            print("TODO: Add to watchlist")
                        } label: {
                            CircleIconView(icon: "plus")
                        }
                        TrailerButton(movie: movies[heroIndex])
                        NavigationLink {
                            MovieDetailView(movie: movies[heroIndex])
                        } label: {
                            CircleIconView(icon: "info")
                        }
                    }
                    .padding(.top, 6)
                }
                .padding(.bottom, 20)
                .padding(.horizontal)
            }
        }
        .frame(height: heroHeight)
    }
}

// Loads a TMDB image URL, filling its container. Used everywhere a movie
// poster/backdrop is shown, since none of that art ships with the app anymore.
struct RemoteImage: View {
    let url: URL?
    var contentMode: ContentMode = .fill

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .empty:
                Color(white: 0.12)
                    .overlay(ProgressView().tint(.white.opacity(0.6)))
            case .failure:
                Color(white: 0.12)
            @unknown default:
                Color(white: 0.12)
            }
        }
    }
}

struct PosterCard: View {
    let movie: Movie

    var body: some View {
        RemoteImage(url: movie.backdropURL)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
    }
}

struct CircleIconView: View {
    let icon: String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(.white)
            .frame(width: 42, height: 42)
            .background(Color.white.opacity(0.15))
            .clipShape(Circle())
    }
}

struct TrailerButton: View {
    let movie: Movie
    var body: some View {
        NavigationLink {
            VideoPlayerView(movie: movie)
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
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(AppFont.semiBold.font(size: 18))
                .foregroundColor(.white)
            Spacer()
            Button(action: action) {
                HStack(spacing: 2) {
                    Text(actionLabel)
                        .font(AppFont.medium.font(size: 14))
                    Image(systemName: "chevron.right")
                        .font(AppFont.medium.font(size: 12))
                }
                .foregroundStyle(.white)
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
            SectionHeader(title: title, actionLabel: "More") {
                print("TODO: More action")
            }
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
            NavigationLink {
                MovieDetailView(movie: movie)
            } label: {
                RemoteImage(url: movie.posterURL)
                    .frame(width: width, height: height)
                if showBadge {
                    BadgeView(text: movie.badge)
                        .padding(8)
                }
            }
        }
        .clipShape(.rect(cornerRadius: 14))
    }
}

struct ComingSoonSection: View {
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Coming Soon", actionLabel: "More") {
                print("TODO: More action")
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(movies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            ComingSoonCard(movie: movie)
                        }
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
            RemoteImage(url: movie.posterURL)
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

    let movie: Movie

    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { proxy in
                RemoteImage(url: movie.backdropURL, contentMode: .fill)
                    .frame(width: proxy.size.width, height: 230)
                    .clipped()
            }
            .frame(height: 230)
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("\(movie.badge) • \(movie.genre) • \(movie.duration)")
                        .font(AppFont.regular.font(size: 10))
                    Text(movie.title)
                        .font(AppFont.semiBold.font(size: 24))
                        .lineLimit(2)
                }
                Spacer(minLength: 40)
                VStack(alignment: .trailing) {
                    HStack(alignment: .center) {
                        Text(movie.imdbRating)
                            .font(AppFont.bold.font(size: 12))
                        Image(.imdb)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 10)
                    }
                    // Rating - Language
                    HStack(alignment: .center) {
                        MovieAgeRatingView(rating: movie.rating, forgroundColor: .black, backgroundColor: .white)
                        MovieLanguageView(language: movie.languageTags.first ?? "EN", accentColor: .white)
                    }
                }
            }
            .frame(height: 50, alignment: .bottom)
            .minimumScaleFactor(0.5)
            .foregroundStyle(.white)
            .padding()
            .background(
                ZStack {
                    VariableBlurView(
                        maxBlurRadius: 10,
                        direction: .blurredBottomClearTop,
                        startOffset: 10
                    )
                    LinearGradient(
                        colors: [.clear, Color(red: 0.08, green: 0.32, blue: 0.55).opacity(0.55)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            )
        }
        .overlay(alignment: .topLeading) {
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
            .padding()
        }
        .clipShape(.rect(cornerRadius: 14))
        .padding(.horizontal)
    }
}
