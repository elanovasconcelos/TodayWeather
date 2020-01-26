//
//  ServerProtocol.swift
//  TodayWeather
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol ServerProtocol {
    func forecast(location: Location, completion: @escaping (Result<Forecast, ServerError>) -> Void)
}
