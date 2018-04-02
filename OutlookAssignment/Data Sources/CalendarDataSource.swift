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

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return eventSource.offsets.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DayCell else {
			return UICollectionViewCell()
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
