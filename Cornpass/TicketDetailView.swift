//
//  TicketDetailView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 25/05/26.
//

import SwiftUI

struct TicketDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    let ticket: MovieTicket
    private let columns = Array(repeating: GridItem(.flexible(), alignment: .center), count: 3)
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                // Header
                headerView
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
        .navigationBarBackButtonHidden(true)
    }
}

// SUBVIEWS
extension TicketDetailView {
    
    @ViewBuilder
    private var headerView: some View {
        HStack {
            // Back Button
            ToolbarActionButton(image: "arrow_left") {
                dismiss()
            }
            Spacer()
            Text("Ticket Details")
                .font(AppFont.semiBold.font(size: 18))
                .foregroundStyle(.white)
            Spacer()
            // Print Button
            ToolbarActionButton(image: "download") {
                print("TODO: download action")
            }
        }
        .padding(.horizontal)
    }
    
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
                    Spacer()
                        .frame(height: 10)
                    HStack(alignment: .center) {
                        HStack(spacing: 5) {
                            Text(ticket.rating)
                                .foregroundStyle(.white)
                                .font(AppFont.bold.font(size: 10))
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(height: 22)
                                .padding(.horizontal, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.gray.opacity(0.6))
                                )
                            Text(ticket.language)
                                .foregroundStyle(.gray.opacity(0.7))
                                .font(AppFont.bold.font(size: 10))
                                .frame(width: 28, height: 22)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(.gray.opacity(0.7))
                                )
                        }
                        Text(ticket.format)
                            .font(AppFont.medium.font(size: 14))
                            .foregroundStyle(.gray)
                        Text(ticket.audioFormat)
                            .font(AppFont.medium.font(size: 14))
                            .foregroundStyle(.gray)
                    }
                }
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
