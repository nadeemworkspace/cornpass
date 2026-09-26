//
//  CircleIconView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct CircleIconView: View {
    let icon: String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(.white)
            .frame(width: 42, height: 42)
            .background(Color.white.opacity(0.15))
            .clipShape(Circle())
    }
}
