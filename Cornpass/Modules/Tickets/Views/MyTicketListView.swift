//
//  MyTicketListView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 24/05/26.
//

import SwiftUI

struct MyTicketListView: View {

    @State private var tickets: [Ticket] = Ticket.tickets
    @State private var showSearchBar: Bool = false
    @State private var searchText: String = ""

    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            VStack {
                // Search Field
                if showSearchBar {
                    HStack(spacing: 8) {
                        GlassSearchField(placeholder: "Search by title", text: $searchText)
                        GlassCircleButton(systemImage: "xmark") {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                showSearchBar = false
                            }
                        }
                    }
                    .padding(.horizontal)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .frame(height: 40)
                }

                ScrollView {
                    ForEach(tickets) { ticket in
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
                .padding(.top)
            }
        }
        .navigationTitle("My Tickets")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !showSearchBar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolbarIconButton(systemImage: "magnifyingglass") {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            showSearchBar = true
                        }
                    }
                }
            }
        }
        .onDisappear {
            showSearchBar = false
        }
        .onChange(of: searchText) { _, new in
            let seachText = new.trimmed
            let allTickets = Ticket.tickets
            if seachText.isEmpty {
                tickets = allTickets
            } else {
                tickets = allTickets.filter {
                    $0.movieTitle.localizedCaseInsensitiveContains(seachText)
                }
            }
        }
    }
}
