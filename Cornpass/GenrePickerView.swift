//
//  GenrePickerView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 24/05/26.
//

import SwiftUI
import SpriteKit

struct GenrePickerView: View {

    @State private var genres = Genre.all
    var selectedCount: Int { genres.filter(\.isSelected).count }

    private func canvasHeight(for width: CGFloat) -> CGFloat {
        let rows  = buildRows(genres: genres, canvasWidth: width)
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
                        print("TODO: Skip action")
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
                    GravityBoard(genres: genres, canvasHeight: h) {
                        genres = $0
                    }
                    .frame(width: geo.size.width, height: h)
                }
                .frame(maxWidth: .infinity)
                // Primary Button
                PrimaryButton(title: selectedCount > 0 ? "Continue  ·  \(selectedCount) selected" : "Select favorit genres") {
                    print("TODO: Genre selection")
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    GenrePickerView()
}
