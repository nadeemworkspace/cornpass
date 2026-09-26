//
//  MainTicketShape.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 25/05/26.
//

import SwiftUI

struct MainTicketShape: Shape {
    func path(in rect: CGRect) -> Path {
        let sx = rect.width / 345.0
        let sy = rect.height / 465.0
        
        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: x * sx, y: y * sy)
        }
        
        var path = Path()

        path.move(to: p(224, 0))

        path.addCurve(
            to: p(191.604, 18.4115),
            control1: p(211.85, 0),
            control2: p(201.591, 11.4922)
        )

        path.addCurve(
            to: p(173, 24),
            control1: p(186.568, 21.9),
            control2: p(180.081, 24)
        )

        path.addCurve(
            to: p(154.396, 18.4115),
            control1: p(165.919, 24),
            control2: p(159.432, 21.9)
        )

        path.addCurve(
            to: p(122, 0),
            control1: p(144.409, 11.4922),
            control2: p(134.15, 0)
        )

        path.addLine(to: p(38.4, 0))

        path.addCurve(
            to: p(13.1042, 2.61584),
            control1: p(24.9587, 0),
            control2: p(18.2381, 0)
        )

        path.addCurve(
            to: p(2.61584, 13.1042),
            control1: p(8.58834, 4.9168),
            control2: p(4.9168, 8.58834)
        )

        path.addCurve(
            to: p(0, 38.4),
            control1: p(0, 18.2381),
            control2: p(0, 24.9587)
        )

        path.addLine(to: p(0, 426.6))

        path.addCurve(
            to: p(2.61584, 451.896),
            control1: p(0, 440.041),
            control2: p(0, 446.762)
        )

        path.addCurve(
            to: p(13.1042, 462.384),
            control1: p(4.9168, 456.412),
            control2: p(8.58834, 460.083)
        )

        path.addCurve(
            to: p(38.4, 465),
            control1: p(18.2381, 465),
            control2: p(24.9587, 465)
        )

        path.addLine(to: p(122, 465))

        path.addCurve(
            to: p(154.396, 446.589),
            control1: p(134.15, 465),
            control2: p(144.409, 453.508)
        )

        path.addCurve(
            to: p(173, 441),
            control1: p(159.432, 443.1),
            control2: p(165.919, 441)
        )

        path.addCurve(
            to: p(191.604, 446.589),
            control1: p(180.081, 441),
            control2: p(186.568, 443.1)
        )

        path.addCurve(
            to: p(224, 465),
            control1: p(201.591, 453.508),
            control2: p(211.85, 465)
        )

        path.addLine(to: p(306.6, 465))

        path.addCurve(
            to: p(331.896, 462.384),
            control1: p(320.041, 465),
            control2: p(326.762, 465)
        )

        path.addCurve(
            to: p(342.384, 451.896),
            control1: p(336.412, 460.083),
            control2: p(340.083, 456.412)
        )

        path.addCurve(
            to: p(345, 426.6),
            control1: p(345, 446.762),
            control2: p(345, 440.041)
        )

        path.addLine(to: p(345, 38.4))

        path.addCurve(
            to: p(342.384, 13.1042),
            control1: p(345, 24.9587),
            control2: p(345, 18.2381)
        )

        path.addCurve(
            to: p(331.896, 2.61584),
            control1: p(340.083, 8.58834),
            control2: p(336.412, 4.9168)
        )

        path.addCurve(
            to: p(306.6, 0),
            control1: p(326.762, 0),
            control2: p(320.041, 0)
        )

        path.addLine(to: p(224, 0))

        path.closeSubpath()

        return path
    }
}
