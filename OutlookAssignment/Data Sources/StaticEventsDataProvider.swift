//
//  StaticEventsDataProvider.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 31/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation

class StaticEventsDataProvider: EventDataProvider {

	let calendar: Calendar
	let avatars: [Attendee.Avatar] = [.image(#imageLiteral(resourceName: "AC")), .image(#imageLiteral(resourceName: "KM")), .image(#imageLiteral(resourceName: "NM")), .image(#imageLiteral(resourceName: "JD"))]

	init(calendar: Calendar) {
		self.calendar = calendar
	}

	//TODO: Replace EventViewModels with actual Events
	func loadEvents(from startDate: Date, to endDate: Date, completion: @escaping ([(Date, [EventViewModel])]) -> Void) {
		let today = Date()
		let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!

		//simulating lots of avatars
		let attendees = (avatars + avatars + avatars + avatars).enumerated().map{ Attendee(name: "Attendee \($0)", avatar: $1) }

		let todaysEvents: [EventViewModel] = [
			EventViewModel(title: "Chaitra Sukhaldi", timing: .allDay, eventHighlightColor: .orange, attendees: [], location: nil),
			EventViewModel(title: "Spring Team Social", timing: .timed(startingTime: "2:00 PM", duration: "30m"), eventHighlightColor: .green, attendees: attendees, location: "Kayako Gurgaon Alpha")
		]

		let tomorrowsEvents: [EventViewModel] = [
			EventViewModel(title: "Disney movie marathon", timing: .allDay, eventHighlightColor: .orange, attendees: [], location: nil)
		]

		completion([(today, todaysEvents), (tomorrow, tomorrowsEvents)])
	}

}
