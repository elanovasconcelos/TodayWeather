//
//  BaseTests.swift
//  TodayWeatherTests
//
//  Created by Elano on 26/01/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import XCTest

class BaseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func error(_ obj1: Any, obj2: Any) -> String
    {
        return "ERROR: \(obj1) != \(obj2)"
    }
    
    func check(_ value1: String?, _ value2: String?, file: StaticString = #file, line: UInt = #line)
    {
        XCTAssert(value2 != nil)
        XCTAssert(value1 == value2, error(value1!, obj2: value2!), file: file, line: line)
    }
    
    func check(_ value1: Int?, _ value2: Int?, file: StaticString = #file, line: UInt = #line)
    {
        XCTAssert(value2 != nil)
        XCTAssert(value1 == value2, error(value1!, obj2: value2!), file: file, line: line)
    }

}
