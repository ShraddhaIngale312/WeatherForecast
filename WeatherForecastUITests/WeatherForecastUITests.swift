//
//  WeatherForecastUITests.swift
//  WeatherForecastUITests
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//

import XCTest

class WeatherForecastUITests: XCTestCase {

    override func setUp() {
     
    }

    override func tearDown() {
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
