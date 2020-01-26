//
//  MainViewModel.swift
//  TodayWeather
//
//  Created by Elano on 25/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
    func mainViewModelChangedData(_ model: MainViewModel)
}

final class MainViewModel: NSObject {

    private let server: ServerModel?
    private var forecast: Forecast? {
        didSet {
            setup()
            delegate?.mainViewModelChangedData(self)
        }
    }
    
    weak var delegate: MainViewModelDelegate?
    
    private(set) var wheaderImage: UIImage!
    private(set) var detailCount: Int = 0
    private(set) var temperature: String = ""
    
    init(forecast: Forecast? = nil, server: ServerModel? = ServerModel.shared) {
        self.forecast = forecast
        self.server = server
    }
    
    private func setup() {
        wheaderImage = getWheaderImage()
        detailCount = getDetailCount()
        temperature = getTemperature()
    }
    
}

//MARK: - Public Functions
extension MainViewModel {
    func update() {
        server?.forecast { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
            case .success(let forecast):
                self?.forecast = forecast
            }
        }
    }

    func shouldShowRows() -> Bool {
        return forecast != nil
    }
 
    func detail(for indexPath: IndexPath) -> (title: String, information: String) {
        
        let weatherDetail = WeatherDetail.forIndex(indexPath.row)
        let currentInformation = information(for: weatherDetail)
        
        return (title: weatherDetail.rawValue, information: currentInformation)
    }
}

//MARK: - Private
extension MainViewModel {
    
    private func getTemperature() -> String {
        guard let newValue = forecast?.currently.temperature else { return "" }

        return "\(toCelsius(newValue))°"
    }
    
    private func toCelsius(_ fahrenheit: Double) -> Int {
        return Int((fahrenheit - 32) * 5 / 9)
    }
    
    private func getWheaderImage() -> UIImage {
           
       if let imageName = forecast?.currently.icon, let image = UIImage(named: imageName) {
           return image
       }
       
       return UIImage(named: "clear-day")!
    }
    
    private func getDetailCount() -> Int {
        
        if !shouldShowRows() {
            return 0
        }
        
        return WeatherDetail.values().count
    }
    
    private func information(for detail: WeatherDetail) -> String {
        return doubleFormat(doubleInformation(for: detail))
    }
    
    private func doubleInformation(for detail: WeatherDetail) -> Double? {
        switch detail {
        case .apparentTemperature: return forecast?.currently.apparentTemperature
        case .temperature: return forecast?.currently.temperature
        case .humidity: return forecast?.currently.humidity
        case .windSpeed: return forecast?.currently.windSpeed
        case .uvIndex: return forecast?.currently.uvIndex
        }
    }
    
    private func doubleFormat(_ value: Double?) -> String {
        
        guard let value = value else { return ""}
        
        return "\(value)"
    }
}

//MARK: - Enum
extension MainViewModel {
    enum WeatherDetail: String {
        case temperature = "Temperature"
        case apparentTemperature = "Apparent temperature"
        case humidity = "Humidity"
        case windSpeed = "Wind speed"
        case uvIndex = "UV index"
        
        /// It returns all the WeatherDetail values. It's the row order too.
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
}
