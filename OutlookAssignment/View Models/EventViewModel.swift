//
//  Event.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 10/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

struct EventViewModel {

	// Events can be either All-Day or from a specific time spanning a duration. Kept as Strings cos that's all you need for a viewModel
	enum EventTiming {
		case allDay
		case timed(startingTime: String, duration: String)
	}

	// The title of the event
	let title: String

	let timing: EventTiming

	// The color of the "dot" in the UI. I couldn't quite grok what they meant (some of them displayed with icons for birthdays, skype calls etc), but I couldn't figure out what they represented. In an ideal scenario, this'd be an enum with that information represented
	let eventHighlightColor: UIColor

	let attendees: [Attendee]

	// The locaiton of the event. It's a string for now, but in a real-world app probably has lots of location metadata around it
	let location: String?

}
