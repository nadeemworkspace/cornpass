//
//  LandingView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 23/05/26.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            // Poster Container
            VStack {
                Image(.poster)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                Spacer()
            }
            // Content
            VStack(spacing: 0) {
                Spacer()
                Image(.logoWhite)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 114, height: 92)
                    .padding(.bottom)
                Group {
                    Text("Experience Cinema Like\nNever Before!")
                        .foregroundStyle(.white)
                        .font(AppFont.semiBold.font(size: 24))
                        .padding(.bottom, 10)
                    Text("Find the latest releases, explore top-rated films,\nand secure your seat today.")
                        .foregroundStyle(.gray.opacity(0.9))
                        .font(AppFont.regular.font(size: 16))
                }
                .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: 60)
                
                PrimaryButton(title: "Get Started") {
                    print("Get Started")
                }
                .padding()
            }
        }
    }
}

#Preview {
    LandingView()
}
