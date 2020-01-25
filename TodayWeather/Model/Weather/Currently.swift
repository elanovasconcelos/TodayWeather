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
    
    /*
     "time": 1537882620,
     "summary": "Clear",
     "icon": "clear-day",
     "precipIntensity": 0,
     "precipProbability": 0,
     "temperature": 40.46,
     "apparentTemperature": 33.75,
     "dewPoint": 29.59,
     "humidity": 0.65,
     "pressure": 1025.41,
     "windSpeed": 11.15,
     "windGust": 21.55,
     "windBearing": 295,
     "cloudCover": 0.03,
     "uvIndex": 0,
     "visibility": 8.32,
     "ozone": 321.6
     
     */
}
