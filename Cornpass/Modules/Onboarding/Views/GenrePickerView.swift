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
                // Board fills everything above the button — chips spawn off
                // the top edge and fall the full height of the screen, with
                // the title floating over them rather than boxing them into
                // a shorter strip below it.
                ZStack {
                    // Ignoring the top safe area here (not on the title below)
                    // is what actually lets chips fall from the physical top
                    // edge of the screen instead of stopping at the status
                    // bar / notch inset.
                    GeometryReader { geo in
                        GravityBoard(genres: viewModel.genres) {
                            viewModel.genres = $0
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                    .ignoresSafeArea(edges: .top)
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Button("Skip") {
                                viewModel.finishOnboarding(.skip)
                            }
                            .font(AppFont.medium.font(size: 16))
                            .foregroundStyle(.gray)
                            .padding(.horizontal)
                        }
                        .padding(.top, 8)
                        // Title — hit-testing off so taps fall through to the
                        // chips underneath; Skip above stays tappable since
                        // this only covers the text block, not the whole VStack.
                        VStack(spacing: 6) {
                            Text("Have Favorit Genres?")
                                .font(AppFont.medium.font(size: 12))
                            Text("Select Them Here 😁")
                                .font(AppFont.semiBold.font(size: 22))
                        }
                        .padding(.vertical, 18)
                        .foregroundColor(.white)
                        .allowsHitTesting(false)
                        Spacer()
                    }
                }
                // Primary Button
                PrimaryButton(title: viewModel.selectedCount > 0 ? "Continue  ·  \(viewModel.selectedCount) selected" : "Select favorit genres") {
                    viewModel.finishOnboarding(.save)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await viewModel.loadGenres()
        }
    }
}

#Preview {
    GenrePickerView()
}
