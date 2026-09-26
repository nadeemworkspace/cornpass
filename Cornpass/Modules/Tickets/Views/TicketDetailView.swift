//
//  TicketDetailView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 25/05/26.
//

import SwiftUI

struct TicketDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    let ticket: Ticket
    private let columns = Array(repeating: GridItem(.flexible(), alignment: .center), count: 3)
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 80)
                // Ticket
                ticketView
                Spacer()
                PrimaryButton(title: "Send ticket") {
                    print("TODO: Send ticket")
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Ticket Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ToolbarIconButton(systemImage: "chevron.backward") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarIconButton(systemImage: "arrow.down") {
                    print("TODO: download action")
                }
            }
        }
    }
}

// SUBVIEWS
extension TicketDetailView {

    @ViewBuilder
    private var ticketView: some View {
        ZStack {
            MainTicketShape()
                .fill(.gray)
                .frame(width: 311, height: 388)
                .offset(y: -60)
            MainTicketShape()
                .fill(.white)
                .frame(width: 345, height: 465)
                .overlay {
                    ticketContent
                }
        }
    }
    
    @ViewBuilder
    private var ticketContent: some View {
        VStack {
            subheaderView
            // Film Details
            HStack(alignment: .center) {
                Image(ticket.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading) {
                    Text(ticket.movieTitle)
                        .font(AppFont.semiBold.font(size: 18))
                        .foregroundStyle(.black)
                    Spacer()
                        .frame(height: 10)
                    HStack(alignment: .center) {
                        HStack(spacing: 5) {
                            MovieAgeRatingView(rating: ticket.rating, backgroundColor: .gray.opacity(0.6))
                            MovieLanguageView(language: ticket.language, accentColor: .gray.opacity(0.7))
                        }
                        Text(ticket.format)
                            .font(AppFont.medium.font(size: 14))
                            .foregroundStyle(.gray)
                        Text(ticket.audioFormat)
                            .font(AppFont.medium.font(size: 14))
                            .foregroundStyle(.gray)
                    }
                }
                .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            
            Spacer()
            
            VStack(spacing: 20) {
                LazyVGrid(columns: columns, alignment: .center) {
                    detailContent(title: "Count", value: "\(ticket.ticketCount)")
                    detailContent(title: "Cost", value: "$" + (AppHelper.formattedAmount(ticket.totalAmount)))
                    detailContent(title: "Hall", value: ticket.hall)
                }
                .padding(.horizontal, 10)
                Divider()
                LazyVGrid(columns: columns, alignment: .center) {
                    detailContent(title: "Seats", value: ticket.seats)
                    detailContent(title: "Date", value: ticket.date)
                    detailContent(title: "Time", value: ticket.time)
                }
                .padding(.horizontal, 10)
            }
            Spacer()
            // Barcode
            barcodeView
        }
        .padding()
    }

    @ViewBuilder
    private var subheaderView: some View {
        HStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 4)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#9EE8FF"), Color(hex: "009DCE")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 16, height: 16)
            Text(ticket.cinema)
                .font(AppFont.semiBold.font(size: 12))
                .foregroundStyle(.black)
            Spacer()
            Image(.logoBlackSmall)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 24)
        }
        .padding(.top)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private func detailContent(title: String, value: String) -> some View {
        VStack(alignment: .center) {
            Text(title)
                .font(AppFont.medium.font(size: 12))
                .foregroundStyle(.gray)
            Text(value)
                .font(AppFont.regular.font(size: 16))
                .foregroundStyle(.black)
        }
    }
    
    @ViewBuilder
    private var barcodeView: some View {
        VStack {
            Image(.barcodeLandscape)
                .resizable()
                .scaledToFit()
                .frame(width: 263, height: 67)
            Text("Show this code to the gatekeeper at the cinema")
                .font(AppFont.medium.font(size: 12))
                .foregroundStyle(.gray.opacity(0.7))
        }
        .padding(.bottom, 30)
    }
    
}

#Preview {
    TicketDetailView(ticket: .tickets.first!)
}
