//
//  CalendarDataSource.swift
//  OutlookAssignment_iOS
//
//  Created by Robin Malhotra on 01/04/18.
//

import UIKit

class CalendarDataSource: NSObject, UICollectionViewDataSource {

	let eventSource: EventSource

	init(eventSource: EventSource) {
		self.eventSource = eventSource
	}

	// There's only one section, and this lets us leverage UICollectionViewFlowLayout so that new months start on the same line
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return eventSource.offsets.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DayCell else {
			// a fatalError() would _probably_ be a better option here, because you probably have done something heinously wrong if your cells aren't dequeuing 🙃
			fatalError("Cell not created for Calendar View")
		}
		if let date = eventSource.dateFrom(offset: indexPath.row) {
			let day = eventSource.calendar.component(.day, from: date)
			let month = eventSource.calendar.component(.month, from: date)
			let monthName = eventSource.calendar.shortMonthSymbols[month - 1]
			cell.configure(with: day, month: monthName, isMonthOdd: (month % 2 == 0))
		}
		return cell
	}

}
