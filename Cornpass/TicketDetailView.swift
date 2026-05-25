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
    let columns = Array(repeating: GridItem(.flexible(), alignment: .center), count: 3)
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                // Header
                HStack {
                    Circle()
                        .fill(.white.opacity(0.5))
                        .frame(width: 56, height: 56)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    Text("Ticket Details")
                        .font(AppFont.semiBold.font(size: 18))
                        .foregroundStyle(.white)
                    Spacer()
                    Circle()
                        .fill(.clear)
                        .frame(width: 56, height: 56)
                }
                .padding(.horizontal)
                
                Spacer()
                    .frame(height: 80)
                
                ZStack {
                    MainTicketShape()
                        .fill(.gray)
                        .frame(width: 311, height: 388)
                        .offset(y: -60)
                    MainTicketShape()
                        .fill(.white)
                        .frame(width: 345, height: 465)
                        .overlay {
                            VStack {
                                HStack {
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
                                                Text("13+")
                                                    .foregroundStyle(.white)
                                                    .font(AppFont.bold.font(size: 10))
                                                    .frame(width: 28, height: 22)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 4)
                                                            .fill(.gray.opacity(0.6))
                                                    )

                                                Text("EN")
                                                    .foregroundStyle(.gray.opacity(0.7))
                                                    .font(AppFont.bold.font(size: 10))
                                                    .frame(width: 28, height: 22)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 4)
                                                            .stroke(.gray.opacity(0.7))
                                                    )
                                            }
                                            Text("ScreenX")
                                                .font(AppFont.medium.font(size: 14))
                                                .foregroundStyle(.gray)
                                            Text("Dolby Atmos")
                                                .font(AppFont.medium.font(size: 14))
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 10)
                                
                                Spacer()
                                
                                // Ticket Price Details
//                                VStack(spacing: 20) {
//                                    HStack {
//                                        VStack(alignment: .leading) {
//                                            Text("Amount")
//                                            Text("$5.00")
//                                        }
//                                        Spacer()
//                                        VStack(alignment: .leading) {
//                                            Text("Cost")
//                                            Text("$5.00")
//                                        }
//                                        Spacer()
//                                        VStack(alignment: .leading) {
//                                            Text("Hall")
//                                            Text("4")
//                                        }
//                                    }
//                                    .padding(.horizontal, 10)
//                                    
//                                    Divider()
//                            
//                                    HStack {
//                                        VStack(alignment: .leading) {
//                                            Text("Seats")
//                                            Text("E4")
//                                        }
//                                        Spacer()
//                                        VStack(alignment: .leading) {
//                                            Text("Date")
//                                            Text(ticket.date)
//                                        }
//                                        Spacer()
//                                        VStack(alignment: .leading) {
//                                            Text("Time")
//                                            Text(ticket.time)
//                                        }
//                                    }
//                                    .padding(.horizontal, 10)
//                                }
                                
                                VStack(spacing: 20) {
                                    
                                    LazyVGrid(columns: columns, alignment: .center) {
                                        VStack(alignment: .center) {
                                            Text("Amount")
                                                .font(AppFont.medium.font(size: 12))
                                                .foregroundStyle(.gray)
                                            Text("$5.00")
                                                .font(AppFont.regular.font(size: 16))
                                        }

                                        VStack(alignment: .center) {
                                            Text("Cost")
                                                .font(AppFont.medium.font(size: 12))
                                                .foregroundStyle(.gray)
                                            Text("$5.00")
                                                .font(AppFont.regular.font(size: 16))
                                        }

                                        VStack(alignment: .center) {
                                            Text("Hall")
                                                .font(AppFont.medium.font(size: 12))
                                                .foregroundStyle(.gray)
                                            Text("4")
                                                .font(AppFont.regular.font(size: 16))
                                        }
                                    }
                                    .padding(.horizontal, 10)

                                    Divider()

                                    LazyVGrid(columns: columns, alignment: .center) {
                                        VStack(alignment: .center) {
                                            Text("Seats")
                                                .font(AppFont.medium.font(size: 12))
                                                .foregroundStyle(.gray)
                                            Text("E4")
                                                .font(AppFont.regular.font(size: 16))
                                        }

                                        VStack(alignment: .center) {
                                            Text("Date")
                                                .font(AppFont.medium.font(size: 12))
                                                .foregroundStyle(.gray)
                                            Text(ticket.date)
                                                .font(AppFont.regular.font(size: 16))
                                        }

                                        VStack(alignment: .center) {
                                            Text("Time")
                                                .font(AppFont.medium.font(size: 12))
                                                .foregroundStyle(.gray)
                                            Text(ticket.time)
                                                .font(AppFont.regular.font(size: 16))
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                }
                                
                                Spacer()
                                
                                // Barcode
                                VStack {
                                    Image(.barcodeLandscape)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 263, height: 67)
                                    Text("Show this code to the gatekeeper at the cinema")
                                        .font(AppFont.medium.font(size: 12))
                                        .foregroundStyle(.gray)
                                }
                                .padding(.bottom, 30)
                            }
                            .padding()
                        }
                }
                
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

#Preview {
    TicketDetailView(ticket: .tickets.first!)
}
