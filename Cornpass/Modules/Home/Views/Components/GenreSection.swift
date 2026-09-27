//
//  GenreSection.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

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
                GlassEffectContainer(spacing: 8) {
                    HStack(spacing: 8) {
                        ForEach(genres) { genre in
                            genreChip(genre: genre)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    func genreChip(genre: Genre) -> some View {
        let isSelected = selectedGenres.contains(genre.name)
        return Button {
            if isSelected {
                selectedGenres.remove(genre.name)
            } else {
                selectedGenres.insert(genre.name)
            }
        } label: {
            Text(genre.name)
                .foregroundStyle(isSelected ? .black : .white)
                .font(AppFont.medium.font(size: 16))
                .padding(.vertical)
                .padding(.horizontal, 20)
        }
        .buttonStyle(.plain)
        .glassEffect(isSelected ? .regular.tint(.white).interactive() : .regular.interactive(), in: .capsule)
        .animation(.spring, value: selectedGenres)
    }
}
