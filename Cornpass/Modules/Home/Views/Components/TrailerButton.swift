//
//  TrailerButton.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

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
