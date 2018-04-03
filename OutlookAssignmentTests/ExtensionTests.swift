//
//  ExtensionTests.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 01/04/18.
//

import XCTest

class ExtensionTests: XCTestCase {

	func testRectCentering() {
		let bigRect = CGRect(x: 0, y: 0, width: 100, height: 100)
		let smallRect = CGSize(width: 50, height: 50).centeredVertically(in: bigRect, left: 10)

		XCTAssert(smallRect == CGRect(x: 10, y: 25, width: 50, height: 50))
	}

	func testCollectionAtIndex() {
		let range = 0...100
		//This is a great candidate for fuzz testing via something like https://github.com/typelift/SwiftCheck
		XCTAssert(range.element(at: 40) == 40)
	}
    
}
