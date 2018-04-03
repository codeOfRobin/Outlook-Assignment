//
//  DayTests.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 01/04/18.
//

import XCTest
@testable import OutlookAssignment

class DayTests: XCTestCase {

	func testInitFromComponents() {
		let calendar = Calendar(identifier: .gregorian)
		let dateComponents = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond], from: Date())
		let day = Day(from: dateComponents)

		XCTAssertEqual(day?.day, dateComponents.day)
		XCTAssertEqual(day?.month, dateComponents.month)
		XCTAssertEqual(day?.year, dateComponents.year)
		XCTAssertEqual(day?.era, dateComponents.era)
		XCTAssertNotEqual(day?.dateComponents.minute, dateComponents.minute)
	}

	func testInitFromDate() {
		let calendar = Calendar(identifier: .gregorian)
		let currentInstance = Date()
		let day = Day(from: currentInstance, calendar: calendar)
		let newDate = calendar.date(from: day!.dateComponents)

		XCTAssert(newDate != currentInstance)

	}
    
}
