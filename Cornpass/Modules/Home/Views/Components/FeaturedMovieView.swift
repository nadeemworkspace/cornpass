//
//  FeaturedMovieView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

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
            .glassEffect(.regular, in: .rect)
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
