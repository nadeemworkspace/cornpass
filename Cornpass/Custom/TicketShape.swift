//
//  TicketShape.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 24/05/26.
//

import SwiftUI

struct TicketShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.width
        let h = rect.height

        // Scale factors based on original SVG size
        let sx = w / 345.0
        let sy = h / 130.0

        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(x: x * sx, y: y * sy)
        }

        path.move(to: p(122.567, 0))

        path.addCurve(
            to: p(102, 8),
            control1: p(115.626, 0),
            control2: p(108.94, 8)
        )

        path.addCurve(
            to: p(81.4331, 0),
            control1: p(95.0595, 8),
            control2: p(88.3736, 0)
        )

        path.addLine(to: p(25.6, 0))

        path.addCurve(
            to: p(8.73615, 1.7439),
            control1: p(16.6392, 0),
            control2: p(12.1587, 0)
        )

        path.addCurve(
            to: p(1.7439, 8.73615),
            control1: p(5.72556, 3.27787),
            control2: p(3.27787, 5.72556)
        )

        path.addCurve(
            to: p(0, 25.6),
            control1: p(0, 12.1587),
            control2: p(0, 16.6392)
        )

        path.addLine(to: p(0, 104.4))

        path.addCurve(
            to: p(1.7439, 121.264),
            control1: p(0, 113.361),
            control2: p(0, 117.841)
        )

        path.addCurve(
            to: p(8.73615, 128.256),
            control1: p(3.27787, 124.274),
            control2: p(5.72556, 126.722)
        )

        path.addCurve(
            to: p(25.6, 130),
            control1: p(12.1587, 130),
            control2: p(16.6392, 130)
        )

        path.addLine(to: p(81.4331, 130))

        path.addCurve(
            to: p(102, 122),
            control1: p(88.3736, 130),
            control2: p(95.0595, 122)
        )

        path.addCurve(
            to: p(122.567, 130),
            control1: p(108.94, 122),
            control2: p(115.626, 130)
        )

        path.addLine(to: p(319.4, 130))

        path.addCurve(
            to: p(336.264, 128.256),
            control1: p(328.361, 130),
            control2: p(332.841, 130)
        )

        path.addCurve(
            to: p(343.256, 121.264),
            control1: p(339.274, 126.722),
            control2: p(341.722, 124.274)
        )

        path.addCurve(
            to: p(345, 104.4),
            control1: p(345, 117.841),
            control2: p(345, 113.361)
        )

        path.addLine(to: p(345, 25.6))

        path.addCurve(
            to: p(343.256, 8.73615),
            control1: p(345, 16.6392),
            control2: p(345, 12.1587)
        )

        path.addCurve(
            to: p(336.264, 1.7439),
            control1: p(341.722, 5.72556),
            control2: p(339.274, 3.27787)
        )

        path.addCurve(
            to: p(319.4, 0),
            control1: p(332.841, 0),
            control2: p(328.361, 0)
        )

        path.addLine(to: p(122.567, 0))

        path.closeSubpath()

        return path
    }
}
