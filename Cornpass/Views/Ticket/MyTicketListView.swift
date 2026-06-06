//
//  MyTicketListView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 24/05/26.
//

import SwiftUI

struct MyTicketListView: View {

    @Namespace private var namespace

    var body: some View {
        ZStack {
            // Background
            Color.black
                .ignoresSafeArea()
            VStack {
                // Header
                headerView

                // Seach Field
                Rectangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: 49)
                    .clipShape(Capsule())
                    .padding(.vertical)
                    .padding(.horizontal)
                
                ScrollView {
                    ForEach(Ticket.tickets) { ticket in
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
            // Print Button
            ToolbarActionButton(image: "download") {
                print("TODO: download action")
            }
        }
        .padding()
    }

}
