//
//  MyTicketsView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 24/05/26.
//

import SwiftUI

struct MyTicketsView: View {
    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            VStack {
                // Header
                HStack {
                    Circle()
                        .fill(.white.opacity(0.5))
                        .frame(width: 56, height: 56)
                    Spacer()
                    Text("My Tickets")
                        .font(AppFont.semiBold.font(size: 18))
                        .foregroundStyle(.white)
                    Spacer()
                    Circle()
                        .fill(.clear)
                        .frame(width: 56, height: 56)
                }
                .padding(.horizontal)
                
                // Seach Field
                Rectangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 49)
                    .clipShape(Capsule())
                    .padding(.vertical)
                    .padding(.horizontal)
                
                ScrollView {
                    ForEach(MovieTicket.tickets) { ticket in
                        NavigationLink {
                            TicketDetailView(ticket: ticket)
                        } label: {
                            TicketView(ticket: ticket)
                                .frame(height: 130)
                                .padding(.bottom)
                                .padding(.horizontal)
                        }
                    }
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}
