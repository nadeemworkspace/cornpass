//
//  HorizontalMovieSection.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

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
