//
//  Day.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 31/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation

struct Day: Equatable, Hashable {

	// immutability!
	let dateComponents: DateComponents

	var day: Int? {
		return dateComponents.day
	}
	var month: Int? {
		return dateComponents.month
	}
	var year: Int? {
		return dateComponents.year
	}
	var era: Int? {
		return dateComponents.era
	}

	init?(from date: Date, calendar: Calendar) {
		let components = calendar.dateComponents([.day, .month, .year, .era], from: date)
		self.init(from: components)
	}

	init?(from components: DateComponents) {
		var newComponents = DateComponents()
		newComponents.day = components.day
		newComponents.month = components.month
		newComponents.year = components.year
		newComponents.era = components.era
		self.dateComponents = newComponents
	}

	static func ==(lhs: Day, rhs: Day) -> Bool {
		return lhs.dateComponents == rhs.dateComponents
	}

	var hashValue: Int {
		return dateComponents.hashValue
	}
}
