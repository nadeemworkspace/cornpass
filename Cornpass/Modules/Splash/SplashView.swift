//
//  SplashView.swift
//  Cornpass
//
//  Created by muhammed.nadeem.m.a on 06/06/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Splash screen")
                ProgressView()
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    SplashView()
}
