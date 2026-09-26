//
//  SearchResultRow.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct SearchResultRow: View {

    let result: MovieSearchResult

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                Text(result.movie.title)
                    .font(AppFont.semiBold.font(size: 16))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                if !result.genres.isEmpty {
                    Text(result.genres.prefix(3).joined(separator: " • "))
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(.white.opacity(0.7))
                        .lineLimit(1)
                }
                if let date = result.releaseDate {
                    Label(Self.dateFormatter.string(from: date), systemImage: "calendar")
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(.white.opacity(0.7))
                }
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text(result.movie.imdbRating)
                        .foregroundStyle(.white)
                }
                .font(AppFont.medium.font(size: 13))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            RemoteImage(url: result.movie.posterURL)
                .frame(width: 80, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(12)
        .background(Color(hex: "#14181B"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .contentShape(Rectangle())
    }
}
