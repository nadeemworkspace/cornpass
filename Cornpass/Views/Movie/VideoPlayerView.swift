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
                // Header
                headerView
                // YT Player
                YouTubePlayerView(player)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension VideoPlayerView {
    
    @ViewBuilder
    private var headerView: some View {
        HStack {
            // Back Button
            ToolbarActionButton(image: "arrow_left") {
                dismiss()
            }
            Spacer()
            Text(movie.title)
                .font(AppFont.semiBold.font(size: 18))
                .foregroundStyle(.white)
            Spacer()
            // Print Button
            ToolbarActionButton(image: "download") {
                print("TODO: download action")
            }
            .opacity(0)
            .disabled(true)
        }
        .padding(.horizontal)
    }
    
}

#Preview {
    VideoPlayerView(movie: Movie.dummy)
}
