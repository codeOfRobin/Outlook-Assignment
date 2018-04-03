//
//  EventCell.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 27/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

	let mainStackView = UIStackView()
	// View that shows the colored dot in the middle
	let dotView = DotView()
	let eventDetailsView = EventDetailsView(frame: .zero)
	let eventTimingView = EventTimingView(frame: .zero)

	// Insets are kept separately in each view for now. Given a style guide from a designer, I'd like to move them to Styles.swift
	let insets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.contentView.addSubview(mainStackView)

		self.mainStackView.addArrangedSubview(eventTimingView)
		self.mainStackView.addArrangedSubview(dotView)
		self.mainStackView.addArrangedSubview(eventDetailsView)

		eventDetailsView.translatesAutoresizingMaskIntoConstraints = false
		dotView.translatesAutoresizingMaskIntoConstraints = false
		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		self.mainStackView.alignEdges(to: self.contentView, insets: insets)

		// calling this is more efficient than setting `isActive = true` for individual constraints
		NSLayoutConstraint.activate([
			dotView.heightAnchor.constraint(equalToConstant: 20.0),
			dotView.widthAnchor.constraint(equalToConstant: 20.0),
			eventTimingView.widthAnchor.constraint(equalToConstant: 80.0)
		])

		self.mainStackView.alignment = .firstBaseline

		self.mainStackView.spacing = 10.0

		self.mainStackView.distribution = .fillProportionally
	}
	
	func configure(with event: EventViewModel) {
		self.dotView.configure(color: event.eventHighlightColor)
		self.eventDetailsView.configure(with: event.attendees.map{ $0.avatar }, eventTitle: event.title, eventLocation: event.location)
		self.eventTimingView.configure(with: event.timing)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
