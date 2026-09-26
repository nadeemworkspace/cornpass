//
//  AppHelper.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import Foundation

struct AppHelper {
    static func formattedAmount(_ amount: Double) -> String {
        String(format: "%.2f", amount)
    }
}
