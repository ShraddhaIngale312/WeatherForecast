//
//  WeatherForecastTests.swift
//  WeatherForecastTests
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class WeatherForecastTests: XCTestCase {
    var sut: DashboardViewController!
   
    override func setUp() {
        continueAfterFailure = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
    }

    func testLabels_StaticText() throws {
        let noDataLabel = try XCTUnwrap(sut.noDataLabel, "NO data Label is not connected")
        XCTAssertEqual(noDataLabel.text, "Please Search City For Weather Information.", "noDataLabel Text  does not Match")

        let humidityStaticTextLabel = try XCTUnwrap(sut.humidityStaticTextLabel, "HUMIDITY Label is not connected")
        XCTAssertEqual(humidityStaticTextLabel.text, "HUMIDITY", "HUMIDITY Text does not Match")

        let tempMaxStaticTextLabel = try XCTUnwrap(sut.tempMaxStaticTextLabel, "AVERAGE MAX TEMPERATURE Label is not connected")
        XCTAssertEqual(tempMaxStaticTextLabel.text, "AVERAGE MAX TEMPERATURE", "AVERAGE MAX TEMPERATURE Text  does not Match")

        let tempMinStaticTextLabel = try XCTUnwrap(sut.tempMinStaticTextLabel, "MIN TEMPERATURE Label is not connected")
        XCTAssertEqual(tempMinStaticTextLabel.text, "AVERAGE MIN TEMPERATURE", "MIN TEMPERATURE Text  does not Match")

        let windStaticTextLabel = try XCTUnwrap(sut.windStaticTextLabel, "WIND Label is not connected")
        XCTAssertEqual(windStaticTextLabel.text, "WIND", "WIND Text  does not Match")

        let cloudStaticTextLabel = try XCTUnwrap(sut.cloudStaticTextLabel, "Cloud Label is not connected")
        XCTAssertEqual(cloudStaticTextLabel.text, "Cloud", "Cloud Text does not Match")
    }

    func testSignupForm_WhenLoaded_TextFieldAreConnected() throws {
        _ = try XCTUnwrap(sut.searchTextField, "The Search UITextField is not connected")
    }

    func testSearchTextField_HasPlaceHolderAndContentTypeSet() throws {
        let searchTextField = try XCTUnwrap(sut.searchTextField, "Email address UITextField is not connected")
        XCTAssertEqual(searchTextField.placeholder, "Search", "Search UITextField placeholder does not Match")
        XCTAssertEqual(searchTextField.textContentType, UITextContentType.location, "Search UITextField does not have an Location Content Type set")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testLocationValidation_WhenInvalidCharactersProvided_ThrowsAnError() {
             XCTAssertNoThrow(try sut.isLocationValid("Sergey"), "The isFirstNameValid() should not have thrown an error when there are no illigal characters provided")
        }
    }

