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
        
        static func values() -> [WeatherDetail] {
            return [
            .temperature,
            .apparentTemperature,
            .humidity,
            .windSpeed,
            .uvIndex
            ]
        }
        
        static func forIndex(_ index: Int) -> WeatherDetail {
            return values()[index]
        }
    }
    
    private let forecast: Forecast
    
    
    init(forecast: Forecast = Forecast.debugValue()) {
        self.forecast = forecast
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return WeatherDetail.values().count
    }
    
    func detail(for indexPath: IndexPath) -> (title: String, information: String) {
        
        let weatherDetail = WeatherDetail.forIndex(indexPath.row)
        let currentInformation = information(for: weatherDetail)
        
        return (title: weatherDetail.rawValue, information: currentInformation)
    }
    
    private func information(for detail: WeatherDetail) -> String {
        return doubleFormat(doubleInformation(for: detail))
    }
    
    private func doubleInformation(for detail: WeatherDetail) -> Double? {
        switch detail {
        case .apparentTemperature: return forecast.currently.apparentTemperature
        case .temperature: return forecast.currently.temperature
        case .humidity: return forecast.currently.humidity
        case .windSpeed: return forecast.currently.windSpeed
        case .uvIndex: return forecast.currently.uvIndex
        }
    }
    
    private func doubleFormat(_ value: Double?) -> String {
        
        guard let value = value else { return ""}
        
        return "\(value)"
    }
}
