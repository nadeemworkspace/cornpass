//
//  TicketView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 25/05/26.
//

import SwiftUI

struct TicketView: View {
    
    let ticket: Ticket
    
    var body: some View {
        ZStack(alignment: .leading) {
            TicketShape()
                .fill(Color.white)
            HStack {
                Image(ticket.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 86, height: 122)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(4)
                VStack(alignment: .leading, spacing: 6) {
                    // Type - rating - Duration
                    Text("\(ticket.genre) • \(ticket.rating) • \(ticket.duration)")
                        .font(AppFont.medium.font(size: 10))
                        .foregroundStyle(.gray)
                    // Movie name
                    Text(ticket.movieTitle)
                        .font(AppFont.semiBold.font(size: 18))
                        .foregroundStyle(.black)
                    // Details
                    ticketDetail(title: ticket.cinema, image: "location")
                    ticketDetail(title: ticket.date, image: "clock")
                    ticketDetail(title: "\(ticket.ticketCount) Tickets", image: "ticket")
                }
                .padding(.leading, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                VerticalDottedLine()
                    .stroke(
                        Color.gray.opacity(0.5),
                        style: StrokeStyle(
                            lineWidth: 1,
                            dash: [3, 2]
                        )
                    )
                    .frame(width: 1)
                    .padding(.trailing, 3)
                
                Image(.barcode)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 102)
                    .padding(.trailing, 10)
            }
        }
    }
    
    func ticketDetail(title: String, image: String) -> some View {
        HStack(alignment: .center, spacing: 5) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
            Text(title)
                .font(AppFont.regular.font(size: 12))
                .foregroundStyle(.gray)
        }
    }

}

struct TicketViewPreview: PreviewProvider {
    static var previews: some View {
        TicketView(ticket: .tickets.first!)
            .previewLayout(.fixed(width: 345, height: 130))
            .background(.black)
    }
}
