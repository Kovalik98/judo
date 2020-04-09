//
//  Data.swift
//  JudoistThrows
//
//  Created by Nazar on 12.09.2019.
//  Copyright © 2019 Nazar. All rights reserved.
//



import Foundation

class WorkoutData {
    static let days = [
        40, 40, 60,
        60, 40, 40,
        45, 45, 60,
        60, 60, 90,
        140, 90, 90,
        120, 120, 150,
        60, 150, 150,
        180, 180, 210,
        210, 30, 240,
        240, 270, 300
    ]
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
