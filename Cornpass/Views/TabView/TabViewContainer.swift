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

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home
            Tab(value: .home) {
                HomeView()
            } label: {
                Image(selectedTab == .home ? TabImage.tab_home_fill.rawValue : TabImage.tab_home.rawValue)
            }
            // Feed
            Tab(value: .feed) {
                FeedView()
            } label: {
                Image(selectedTab == .feed ? TabImage.tab_feed_fill.rawValue : TabImage.tab_feed.rawValue)
            }
            // Ticket
            Tab(value: .tickets) {
                MyTicketListView()
            } label: {
                Image(selectedTab == .tickets ? TabImage.tab_ticket_fill.rawValue : TabImage.tab_ticket.rawValue)
            }
            // Profile
            Tab(value: .profile) {
                ProfileView()
            } label: {
                Image(selectedTab == .profile ? TabImage.tab_profile_fill.rawValue : TabImage.tab_profile.rawValue)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FeedView: View {
    var body: some View {
        Text("TODO: FEED")
            .foregroundStyle(.white)
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("TODO: PROFILE")
            Button {
                UserDefaults.standard.set(false, forKey: UserDefaultKeys.userLoggedIn.rawValue)
            } label: {
                Text("Logout")
                    .foregroundStyle(.red)
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    TabViewContainer()
}
