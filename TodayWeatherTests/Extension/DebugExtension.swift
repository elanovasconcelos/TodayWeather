//
//  DebugExtension.swift
//  TodayWeatherTests
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import TodayWeather

extension Forecast {
    static func debugValue() -> Forecast {
        return Forecast(latitude: 1, longitude: 1, timezone: "Europe/Stockholm", currently: Currently.debugValue())
    }
}

extension Currently {
    static func debugValue() -> Currently {
        return Currently(time: 1537882620, summary: "Clear", icon: "clear-day", temperature: 40.46, humidity: 0.65, windSpeed: 11.15, uvIndex: 0, apparentTemperature: 33.75)
    }
}

extension Location {
    static func debugValue() -> Location {
        return Location(latitude: 59.3310373, longitude: 18.062381)
    }
}
