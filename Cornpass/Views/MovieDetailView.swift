//
//  MovieDetailView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 28/05/26.
//

import SwiftUI

/*
 {
   "id": "1",
   "title": "Alien: Romulus",
   "badge": "HOT",
   "genre": "Sci-Fi",
   "rating": "R",
   "duration": "1h 56m",
   "image": "alien_home",
   "videoURL": "https://www.youtube.com/watch?v=OzY2r2JXsDM",
   "description": "Young space colonizers come face to face with the most terrifying life-form in the universe.",
   "ageBadge": "+18",
   "languageTags": ["EN", "Sub EN/FR"],
   "imdbRating": "8.1/10",
   "rottenTomatoesRating": "81%",
   "cornPassRating": "8.4/10",
   "gallery": ["alien_scene_1", "alien_scene_2"],
   "director": ["Fede Álvarez"],
   "writers": ["Fede Álvarez", "Rodo Sayagues"],
   "stars": ["Cailee Spaeny", "David Jonsson", "Archie Renaux"],
   "classification": "R"
 }
 */

struct MovieDetailView: View {
    let movie: Movie
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    // Poster
                    ZStack(alignment: .bottom) {
                        PosterCard(movie: movie)
                            .frame(height: 400, alignment: .top)
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: .black.opacity(0.9), location: 0.9),
                                .init(color: .black, location: 1.0),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 180)
                    }
                    .clipped()
                    // Details
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(movie.genre) • \(movie.rating) • \(movie.duration)")
                            .font(AppFont.medium.font(size: 14))
                            .foregroundStyle(.gray)
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(movie.title)
                                    .font(AppFont.semiBold.font(size: 24))
                                    .foregroundStyle(.white)
                                HStack {
                                    MovieAgeRatingView(rating: movie.ageBadge, forgroundColor: .black, backgroundColor: .white)
                                    ForEach(movie.languageTags, id: \.self) { tag in
                                        MovieLanguageView(language: tag, accentColor: .white)
                                    }
                                }
                            }
                            Spacer()
                            // Play Button
                            NavigationLink {
                                VideoPlayerView(movie: movie)
                            } label: {
                                Image(systemName: "play.fill")
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(.gray.opacity(0.5))
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.horizontal)
                    // Rating Section
                    HStack(alignment: .center) {
                        ratingView(provider: "IMBD", imageName: "imdb_rating", rating: movie.imdbRating)
                        Spacer()
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 1)
                            .padding(.vertical, 10)
                        Spacer()
                        ratingView(provider: "Rotten Tomatoes", imageName: "rottenTomatoes_rating", rating: movie.rottenTomatoesRating)
                        Spacer()
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 1)
                            .padding(.vertical, 10)
                        Spacer()
                        ratingView(provider: "CornPass", imageName: "cornpass_rating", rating: movie.cornPassRating)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    
                    // Movie Description
                    Text(movie.description)
                        .foregroundStyle(.gray)
                        .font(AppFont.regular.font(size: 16))
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0...3, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(.gray.opacity(0.3))
                                    .frame(width: 160, height: 100)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.vertical, 20)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .overlay(alignment: .top) {
            headerView
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private var headerView: some View {
        HStack {
            // Back Button
            ToolbarActionButton(image: "arrow_left") {
                dismiss()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func ratingView(provider: String, imageName: String, rating: String) -> some View {
        VStack(alignment: .center) {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 20)
                Text(rating)
                    .foregroundStyle(.white)
                    .font(AppFont.medium.font(size: 14))
            }
            Text(provider)
                .foregroundStyle(.gray)
                .font(AppFont.medium.font(size: 12))
        }
    }
    
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: Movie.dummy)
    }
}
