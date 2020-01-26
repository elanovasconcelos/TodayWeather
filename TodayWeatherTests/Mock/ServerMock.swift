//
//  ServerMock.swift
//  TodayWeatherTests
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import TodayWeather

class ServerMock: NSObject, ServerProtocol {
    
    var shouldReturnSuccess = true
    
    func forecast(location: Location, completion: @escaping (Result<Forecast, ServerError>) -> Void) {
        if shouldReturnSuccess {
            completion(.success(Forecast.debugValue()))
        }else {
            completion(.failure(.api))
        }
    }
}
