//
//  ComingSoonSection.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

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
