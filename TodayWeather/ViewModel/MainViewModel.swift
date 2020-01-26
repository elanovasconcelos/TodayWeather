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

    static let temperatureSymbol = "°"
    
    private let server: ServerProtocol?
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
    
    init(forecast: Forecast? = nil, server: ServerProtocol? = ServerModel.shared) {
        self.forecast = forecast
        self.server = server
        
        super.init()
        
        setup()
    }
    
    private func setup() {
        wheaderImage = getWheaderImage()
        detailCount = getDetailCount()
        temperature = getTemperature()
    }
    
}

//MARK: - Public Functions
extension MainViewModel {
    func update(with location: Location) {
        server?.forecast(location: location) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("[MainViewModel] error: \(error)")
                //TODO: show error to user
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
        
        return (title: weatherDetail.rawValue + ":", information: currentInformation)
    }
}

//MARK: - Private
extension MainViewModel {
    
    private func getTemperature() -> String {
        guard let newValue = forecast?.currently.temperature else { return "" }

        return "\(Int(toCelsius(newValue)))" + MainViewModel.temperatureSymbol
    }
    
    private func toCelsius(_ fahrenheit: Double?) -> Double {
        
        guard let fahrenheit = fahrenheit else { return 0 }
        
        return (fahrenheit - 32) * 5 / 9
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
        
        switch detail {
        case .apparentTemperature: return doubleFormat(doubleInformation(for: detail)) + MainViewModel.temperatureSymbol
        default:
            return doubleFormat(doubleInformation(for: detail))
        }
    }
    
    private func doubleInformation(for detail: WeatherDetail) -> Double? {
        switch detail {
        case .apparentTemperature: return toCelsius(forecast?.currently.apparentTemperature)
        case .humidity: return forecast?.currently.humidity
        case .windSpeed: return forecast?.currently.windSpeed
        case .uvIndex: return forecast?.currently.uvIndex
        }
    }
    
    private func doubleFormat(_ value: Double?) -> String {
        
        guard let value = value else { return ""}
        
        return String(format: "%.2f", value)
    }
}

//MARK: - Enum
extension MainViewModel {
    enum WeatherDetail: String {
        case apparentTemperature = "Apparent temperature"
        case humidity = "Humidity"
        case windSpeed = "Wind speed"
        case uvIndex = "UV index"
        
        /// It returns all the WeatherDetail values. It's the row order too.
        static func values() -> [WeatherDetail] {
            return [
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
