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
            Tab(value: .home) {
                NavigationStack {
                    HomeView()
                }
            } label: {
                Image(.home)
            }
            // Search
            Tab(value: .search) {
                NavigationStack {
                    SearchView()
                }
            } label: {
                Image(.search)
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
            Tab(value: .profile, role: .search) {
                NavigationStack {
                    ProfileView()
                }
            } label: {
                Image(.profile)
            }
        }
        .tint(.white)
    }
}

#Preview {
    TabViewContainer()
}
