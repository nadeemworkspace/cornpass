//
//  TMDBAttributionView.swift
//  Cornpass
//
//  Created by Nadeem M A, Muhammed on 26/09/26.
//

import SwiftUI

struct TMDBAttributionView: View {
    var body: some View {
        HStack {
            Text("Powered by The Movie Database")
                .font(AppFont.semiBold.font(size: 12))
                .foregroundStyle(.white.opacity(0.5))
            Image(.tmdbLogo3)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TMDBAttributionView()
}
