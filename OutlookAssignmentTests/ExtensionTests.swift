//
//  ExtensionTests.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 01/04/18.
//

import XCTest

class ExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

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
