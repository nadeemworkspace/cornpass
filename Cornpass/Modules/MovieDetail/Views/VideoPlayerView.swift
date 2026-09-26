//
//  VideoPlayerView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 28/05/26.
//

import SwiftUI
import YouTubePlayerKit

struct VideoPlayerView: View {
    
    let movie: Movie
    @Environment(\.dismiss) private var dismiss
    @State private var player: YouTubePlayer
    
    init(movie: Movie) {
        self.movie = movie
         _player = State(initialValue: YouTubePlayer(urlString: movie.videoURL))
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                // YT Player
                YouTubePlayerView(player)
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolbarIconButton(systemImage: "chevron.backward") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    VideoPlayerView(movie: Movie.dummy)
}
