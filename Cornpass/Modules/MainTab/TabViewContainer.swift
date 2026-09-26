//
//  TabViewContainer.swift
//  Cornpass
//
//  Created by muhammed.nadeem.m.a on 05/06/26.
//

import SwiftUI

enum TabItem: Hashable {
    case home, feed, tickets, profile
}

struct TabViewContainer: View {

    @State private var selectedTab: TabItem = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home — each tab gets its own NavigationStack: a title/toolbar
            // set on a tab's root view only bubbles up to that tab's own
            // stack, never to an ancestor NavigationStack wrapping the TabView.
            Tab(value: .home) {
                NavigationStack {
                    HomeView()
                }
            } label: {
                Image(selectedTab == .home ? TabImage.tab_home_fill.rawValue : TabImage.tab_home.rawValue)
            }
            // Search
            Tab(value: .feed) {
                NavigationStack {
                    SearchView()
                }
            } label: {
                Image(selectedTab == .feed ? TabImage.tab_feed_fill.rawValue : TabImage.tab_feed.rawValue)
            }
            // Ticket
            Tab(value: .tickets) {
                NavigationStack {
                    MyTicketListView()
                }
            } label: {
                Image(selectedTab == .tickets ? TabImage.tab_ticket_fill.rawValue : TabImage.tab_ticket.rawValue)
            }
            // Profile — separate role splits it from the first 3 tabs with
            // its own trailing section in the Liquid Glass tab bar.
            Tab(value: .profile, role: .search) {
                NavigationStack {
                    ProfileView()
                }
            } label: {
                Image(selectedTab == .profile ? TabImage.tab_profile_fill.rawValue : TabImage.tab_profile.rawValue)
            }
        }
    }
}

#Preview {
    TabViewContainer()
}
