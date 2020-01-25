//
//  Forecast.swift
//  TodayWeather
//
//  Created by Elano on 25/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct Forecast: Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: Currently
}

//MARK: - Debug
extension Forecast {
    static func debugValue() -> Forecast {
        return Forecast(latitude: 1, longitude: 1, timezone: "Europe/Stockholm", currently: Currently.debugValue())
    }
}
