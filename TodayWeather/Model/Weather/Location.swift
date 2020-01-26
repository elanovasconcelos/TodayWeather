//
//  Location.swift
//  TodayWeather
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct Location {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double = 0, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static func debug() -> Location {
        return Location(latitude: 59.3310373, longitude: 18.062381)
    }
}
