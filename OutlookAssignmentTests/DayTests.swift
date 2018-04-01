//
//  DayTests.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 01/04/18.
//

import XCTest
@testable import OutlookAssignment

class DayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testInitFromComponents() {
		let calendar = Calendar(identifier: .gregorian)
		let dateComponents = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: Date())
		let day = Day(from: dateComponents)

		XCTAssert(day?.day == dateComponents.day)
		XCTAssert(day?.month == dateComponents.month)
		XCTAssert(day?.year == dateComponents.year)
		XCTAssert(day?.era == dateComponents.era)
		XCTAssert(day?.dateComponents.minute != dateComponents.minute)
	}

	func testInitFromDate() {
		let calendar = Calendar(identifier: .gregorian)
		let currentInstance = Date()
		let day = Day(from: currentInstance, calendar: calendar)
		let newDate = calendar.date(from: day!.dateComponents)

		XCTAssert(newDate != currentInstance)

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
    
}
