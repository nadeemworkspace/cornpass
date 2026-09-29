//
//  MovieAgeRatingView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct MovieAgeRatingView: View {
    let rating: String
    let foregroundColor: Color
    let backgroundColor: Color

    init(rating: String, foregroundColor: Color = .white, backgroundColor: Color = .gray) {
        self.rating = rating
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        Text(rating)
            .foregroundStyle(foregroundColor)
            .font(AppFont.bold.font(size: 10))
            .fixedSize(horizontal: true, vertical: false)
            .frame(height: 22)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(backgroundColor)
            )
            .fixedSize(horizontal: true, vertical: false)
    }
}
