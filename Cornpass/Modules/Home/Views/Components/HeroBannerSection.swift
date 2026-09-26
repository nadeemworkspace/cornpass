//
//  HeroBannerSection.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

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
