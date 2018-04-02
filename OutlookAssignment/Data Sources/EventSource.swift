//
//  EventSource.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 01/04/18.
//

import Foundation

class EventSource {
	var events: [Day: [EventViewModel]] = [:]
	//TODO: Needs to be var for midnight date changing reasons
	var today = Date()

	var calendar = Calendar(identifier: .gregorian)
	var offsets = -10000...10000

	init() {
		calendar.locale = Locale.current
	}

	func isDateSameDayAsToday(_ date: Date) -> Bool {
		return calendar.isDate(date, equalTo: today, toGranularity: .day)
	}

	func dateFrom(offset: Int) -> Date? {
		if let offset = offsets.element(at: offset),
			let date = calendar.date(byAdding: .day, value: offset, to: today) {
			return date
		} else {
			return nil
		}
	}

	func eventsFromDataSet(at index: Int) -> [EventViewModel] {
		if let date = dateFrom(offset: index),
			let day = Day(from: calendar.dateComponents([.day, .month, .year, .era], from: date)),
			let events = events[day] {
			return events
		} else {
			return []
		}
	}

	var dateRange: (Date, Date) {
		let firstDate = calendar.date(byAdding: .day, value: offsets.first ?? 0, to: today) ?? Date()
		let lastDate = calendar.date(byAdding: .day, value: offsets.last ?? 0, to: today) ?? Date()
		return (firstDate, lastDate)
	}
}
