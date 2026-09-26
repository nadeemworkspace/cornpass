//
//  GenrePickerView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 24/05/26.
//

import SwiftUI
import SpriteKit

struct GenrePickerView: View {

    @State private var viewModel = GenrePickerViewModel()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button("Skip") {
                        viewModel.navigateToHome(.skip)
                    }
                    .font(AppFont.medium.font(size: 16))
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                }
                .padding(.top, 8)
                // Title
                VStack(spacing: 6) {
                    Text("Have Favorit Genres?")
                        .font(AppFont.medium.font(size: 12))
                    Text("Select Them Here 😁")
                        .font(AppFont.semiBold.font(size: 22))
                }
                .padding(.vertical, 18)
                .foregroundColor(.white)

                // Fills all remaining space between the title and the button;
                // GravityScene keeps chips 16pt clear of both edges.
                GeometryReader { geo in
                    GravityBoard(genres: viewModel.genres) {
                        viewModel.genres = $0
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                // Primary Button
                PrimaryButton(title: viewModel.selectedCount > 0 ? "Continue  ·  \(viewModel.selectedCount) selected" : "Select favorit genres") {
                    viewModel.navigateToHome(.save)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.navigateToHome) {
            TabViewContainer()
        }
        .task {
            await viewModel.loadGenres()
        }
    }
}

#Preview {
    GenrePickerView()
}
