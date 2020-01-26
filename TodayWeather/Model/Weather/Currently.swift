//
//  Currently.swift
//  TodayWeather
//
//  Created by Elano on 25/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct Currently: Decodable {
    
    let time: Double?
    let summary: String?
    let icon: String?
    let temperature: Double?
    let humidity: Double?
    let windSpeed: Double?
    let uvIndex: Double?
    let apparentTemperature: Double?
}
