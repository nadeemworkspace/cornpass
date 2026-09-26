//
//  SectionHeader.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    let actionLabel: String
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(AppFont.semiBold.font(size: 18))
                .foregroundColor(.white)
            Spacer()
            Button(action: action) {
                HStack(spacing: 2) {
                    Text(actionLabel)
                        .font(AppFont.medium.font(size: 14))
                    Image(systemName: "chevron.right")
                        .font(AppFont.medium.font(size: 12))
                }
                .foregroundStyle(.white)
            }
        }
        .padding(.horizontal)
    }
}
