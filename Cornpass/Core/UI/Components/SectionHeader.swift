//
//  SectionHeader.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(AppFont.semiBold.font(size: 18))
            .foregroundColor(.white)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
