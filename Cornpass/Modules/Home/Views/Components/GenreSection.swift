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
