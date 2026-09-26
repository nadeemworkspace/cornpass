//
//  BadgeView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct BadgeView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 9, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 3)
            .background(Color(red: 0.20, green: 0.20, blue: 0.28))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
