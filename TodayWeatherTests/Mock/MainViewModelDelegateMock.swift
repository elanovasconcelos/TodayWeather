//
//  MainViewModelDelegateMock.swift
//  TodayWeatherTests
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import TodayWeather

class MainViewModelDelegateMock: NSObject, MainViewModelDelegate {
    
    var isDelegateCalled = false
    
    func mainViewModelChangedData(_ model: MainViewModel) {
        isDelegateCalled = true
    }
    

}
