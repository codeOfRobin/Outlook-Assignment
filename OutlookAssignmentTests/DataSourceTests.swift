//
//  DataSourceTests.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 02/04/18.
//

import XCTest
@testable import OutlookAssignment

class DataSourceTests: XCTestCase {

	let eventSource = EventSource()
	var calendarDataSource: CalendarDataSource!
	var agendaDataSource: AgendaDataSource!
    
    override func setUp() {
        super.setUp()

		eventSource.events[Day(from: Date(), calendar: eventSource.calendar)!] = [
			EventViewModel(title: "fake event", timing: .allDay, eventHighlightColor: .orange, attendees: [], location: nil),
			EventViewModel(title: "fake event2", timing: .allDay, eventHighlightColor: .orange, attendees: [], location: nil)
		]

		self.calendarDataSource = CalendarDataSource(eventSource: eventSource)
		self.agendaDataSource = AgendaDataSource(eventSource: eventSource)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCalendarDataSource() {

		let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		XCTAssert(calendarDataSource.numberOfSections(in: view) == 1)
		XCTAssert(calendarDataSource.collectionView(view, numberOfItemsInSection: 0) == eventSource.offsets.count)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

	func testAgendaDataSource() {
		let tableView = UITableView()
		XCTAssert(agendaDataSource.numberOfSections(in: tableView) == eventSource.offsets.count)
		XCTAssert(agendaDataSource.tableView(tableView, numberOfRowsInSection: eventSource.offsets.count/2) == 2)
	}
    
}
