//
//  AgendaDataSource.swift
//  OutlookAssignment
//
//  Created by Robin Malhotra on 01/04/18.
//

import UIKit

class AgendaDataSource: NSObject, UITableViewDataSource {
	let eventSource: EventSource

	init(eventSource: EventSource) {
		self.eventSource = eventSource
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return eventSource.offsets.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let events = eventSource.eventsFromDataset(at: section)
		if events.count > 0 {
			return events.count
		} else {
			return 1
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let events = eventSource.eventsFromDataset(at: indexPath.section)

		if events.count > 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventCell else {
				return UITableViewCell()
			}
			cell.configure(with: events[indexPath.row])
			return cell
		} else {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyEventsCell", for: indexPath) as? EmptyEventsTableViewCell else {
				return UITableViewCell()
			}
			cell.configure(text: Constants.Strings.noEvents)
			return cell
		}
	}

}
