//
//  MainViewModelTests.swift
//  TodayWeatherTests
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import XCTest
@testable import TodayWeather

class MainViewModelTests: BaseTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fields() {
        
        let model = debugModel()
        
        check(model.detailCount, 4)
        check(model.temperature, "4" + MainViewModel.temperatureSymbol)
        XCTAssertTrue(model.shouldShowRows())
        XCTAssertTrue(model.wheaderImage != nil)
    }

    func test_detail() {
        let model = debugModel()
        
        let detail0 = model.detail(for: IndexPath(row: 0, section: 0))
        check(detail0.title, "Apparent temperature:")
        check(detail0.information, "0.97°")
        
        let detail1 = model.detail(for: IndexPath(row: 1, section: 0))
        check(detail1.title, "Humidity:")
        check(detail1.information, "0.65")
        
        let detail2 = model.detail(for: IndexPath(row: 2, section: 0))
        check(detail2.title, "Wind speed:")
        check(detail2.information, "11.15")
        
        let detail3 = model.detail(for: IndexPath(row: 3, section: 0))
        check(detail3.title, "UV index:")
        check(detail3.information, "0.00")

    }
    
    func test_nil_forecast() {
        let model = MainViewModel(forecast: nil, server: nil)
        
        check(model.detailCount, 0)
        check(model.temperature, "")
        XCTAssertFalse(model.shouldShowRows())
        XCTAssertTrue(model.wheaderImage != nil)
    }
    
    func test_delegate() {

        let model = MainViewModel(forecast: nil, server: ServerMock())
        let delegate = MainViewModelDelegateMock()
        
        model.delegate = delegate
        
        XCTAssertFalse(delegate.isDelegateCalled)
        XCTAssertFalse(model.shouldShowRows())
        
        model.update(with: Location.debugValue())
        
        XCTAssertTrue(delegate.isDelegateCalled)
        XCTAssertTrue(model.shouldShowRows())
    }
    
    //MARK: -
    private func debugModel() -> MainViewModel {
        let forecast = Forecast.debugValue()
        return MainViewModel(forecast: forecast, server: nil)
    }

}
