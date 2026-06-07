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
    @Namespace private var namespace

    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            VStack {
                // Header
                headerView
                // Search Field
                if showSearchBar {
                    HStack(spacing: 8) {
                        // Capsule Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.white.opacity(0.7))
                                .padding(.leading, 12)
                            TextField("Search by title", text: $searchText)
                                .font(AppFont.regular.font(size: 16))
                                .foregroundStyle(.white)
                                .tint(.white)
                        }
                        .frame(height: 49)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#14181B"))
                        .clipShape(Capsule())
                        .matchedGeometryEffect(id: "searchAnimation", in: namespace, isSource: true)
                        // Close Button
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                showSearchBar = false
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "#14181B"))
                                    .frame(width: 49, height: 49)
                                Image(systemName: "xmark")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(.bottom, 16)
                    .padding(.horizontal)
                    .transition(.identity)
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
            }
        }
        .navigationBarBackButtonHidden(true)
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

extension MyTicketListView {

    @ViewBuilder
    private var headerView: some View {
        HStack {
            // Back Button
            ToolbarActionButton(image: "arrow_left") { }
                .opacity(0)
                .disabled(true)
            Spacer()
            Text("My Tickets")
                .font(AppFont.semiBold.font(size: 18))
                .foregroundStyle(.white)
            Spacer()
            // Search Button
            ToolbarActionButton(image: "search") {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    showSearchBar = true
                }
            }
            .matchedGeometryEffect(id: "searchAnimation", in: namespace, isSource: !showSearchBar)
            .opacity(showSearchBar ? 0 : 1)
            .disabled(showSearchBar)
        }
        .padding()
    }
}
