//
//  Buttons.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 23/05/26.
//

import SwiftUI

// MARK: PRIMARY BUTTON
struct PrimaryButton: View {
    let title: String
    var background: Color = .white
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.semiBold.font(size: 16))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(background)
                .clipShape(Capsule())
        }
    }
}

// MARK: LOGIN ACTION BUTTON
struct LoginActionButton: View {
    let title: String
    let image: ImageResource
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                Text(title)
                    .foregroundStyle(.white)
                    .font(AppFont.regular.font(size: 14))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color(hex: "#14181B"))
            .clipShape(Capsule())
        }
    }
}
