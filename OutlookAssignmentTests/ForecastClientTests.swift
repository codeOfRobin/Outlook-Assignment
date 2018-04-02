//
//  ForecastClientTests.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 02/04/18.
//

import XCTest
@testable import OutlookAssignment

class ForecastClientTests: XCTestCase {

	let requestBuilder = ForecastRequestBuilder.init(apiKey: "fish")
	let point = Point(latitude: 20.0, longitude: 20.0)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

	func testDateSeconds() {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "US_en")
		formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
		// https://stackoverflow.com/questions/25686284/from-string-to-nsdate-in-swift
		let date = formatter.date(from: "Mon, 02 Apr 2018 12:40:26 +0000")!
		XCTAssertEqual(date.secondsSinceEpoch, 1522672826)

		let zeroDate = formatter.date(from: "Thu, 01 Jan 1970 00:00:00 +0000")!
		XCTAssertEqual(zeroDate.secondsSinceEpoch, 0)

	}

	func testRequestBuilderwithForecast() {
		if let url = requestBuilder.request(for: .currentForecast(point))?.url {
			let string = String(describing: url)
			XCTAssertEqual(string, "https://api.darksky.net/forecast/fish/20.0,20.0")
		} else {
			XCTFail()
		}
	}

	func testRequestBuilderwithTimeTravel() {
		if let url = requestBuilder.request(for: .timeTravel(point, 0))?.url {
			let string = String(describing: url)
			XCTAssertEqual(string, "https://api.darksky.net/forecast/fish/20.0,20.0,0")
		} else {
			XCTFail()
		}
	}

	func testJSONDecoding() {
		let jsonData = sampleResponse.data(using: .utf8)!
		let jsonDecoder = JSONDecoder()
		do {
			let weatherResponse = try jsonDecoder.decode(ForecastResponse.self, from: jsonData)
			XCTAssertEqual(weatherResponse.currentForecast.summary, "Clear")
			XCTAssertEqual(weatherResponse.currentForecast.temperature, 52.37)
		} catch {
			XCTFail()
		}
	}

	func testEndToEndWithSession() {
		let client = ForecastAPIClient(session: MockForecastSession(), key: "fish")
		let exp = expectation(description: "end to end session test")
		client.getWeather(for: Point(latitude: 0, longitude: 0)) { (forecast) in
			XCTAssertEqual(forecast.summary, "Clear")
			XCTAssertEqual(forecast.temperature, 52.37)
			exp.fulfill()
		}
		waitForExpectations(timeout: 2.0)
	}

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
