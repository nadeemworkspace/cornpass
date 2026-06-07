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

    private func canvasHeight(for width: CGFloat) -> CGFloat {
        let rows  = buildRows(genres: viewModel.genres, canvasWidth: width)
        let pile  = pileHeight(rows: rows)
        let extra: CGFloat = pile * 0.6
        return pile + extra
    }

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
                
                Spacer()
                
                GeometryReader { geo in
                    let h = canvasHeight(for: geo.size.width)
                    GravityBoard(genres: viewModel.genres, canvasHeight: h) {
                        viewModel.genres = $0
                    }
                    .frame(width: geo.size.width, height: h)
                }
                .frame(maxWidth: .infinity)
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
    }
}

@Observable
class GenrePickerViewModel {

    enum GPAction {
        case skip, save
    }

    var genres = Genre.all
    var selectedCount: Int { genres.filter(\.isSelected).count }
    var navigateToHome: Bool = false

    func navigateToHome(_ action: GPAction) {
        // Save selected if action is .save
        navigateToHome = true
    }

}

#Preview {
    GenrePickerView()
}
