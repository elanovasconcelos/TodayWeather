//
//  MainViewModel.swift
//  TodayWeather
//
//  Created by Elano on 25/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class MainViewModel: NSObject {

    enum WeatherDetail: String {
        case temperature = "Temperature"
        case apparentTemperature = "Apparent temperature"
        case humidity = "Humidity"
        case windSpeed = "Wind speed"
        case uvIndex = "UV index"
        
        static func forIndex(_ index: Int) -> WeatherDetail {
            switch index {
            case 0: return .temperature
            case 1: return .apparentTemperature
            case 2: return .humidity
            case 3: return .windSpeed
            case 4: return .uvIndex
            default:
                assertionFailure()
                return .temperature
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 5
    }
    
    func detail(for indexPath: IndexPath) -> (title: String, information: String) {
        
        let weatherDetail = WeatherDetail.forIndex(indexPath.row)
        
        return (title: "Title", information: "Some information")
    }
    

}
