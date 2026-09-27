//
//  TabViewContainer.swift
//  Cornpass
//
//  Created by muhammed.nadeem.m.a on 05/06/26.
//

import SwiftUI

enum TabItem: Hashable {
    case home, search, tickets, profile
}

struct TabViewContainer: View {

    @State private var selectedTab: TabItem = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home
            Tab(value: .home) {
                NavigationStack {
                    HomeView()
                }
            } label: {
                Image(.home)
            }
            // Ticket
            Tab(value: .tickets) {
                NavigationStack {
                    MyTicketListView()
                }
            } label: {
                Image(.ticket)
            }
            // Profile
            Tab(value: .profile) {
                NavigationStack {
                    ProfileView()
                }
            } label: {
                Image(.profile)
            }
            // Search
            Tab(value: .search, role: .search) {
                NavigationStack {
                    SearchView()
                }
            } label: {
                Image(.search)
            }
        }
        .tint(.white)
    }
}

#Preview {
    TabViewContainer()
}
