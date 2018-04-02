//
//  EventDetailsView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 27/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit


class EventDetailsView: UIView {

	let stackView = UIStackView()

	let presenceView = AttendeesView(frame: .zero)
	let titleLabel = UILabel()
	let locationView = LocationView(frame: .zero)
	let dotView = DotView(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(stackView)
		stackView.axis = .vertical
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(presenceView)
		stackView.addArrangedSubview(locationView)

		presenceView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false

		// A value of 0 means no limit on the number of lines
		titleLabel.numberOfLines = 0

		stackView.spacing = 20.0
		stackView.alignEdges(to: self)
	}

	func configure(with avatars: [Attendee.Avatar], eventTitle: String, eventLocation: String?) {
		presenceView.configure(with: avatars)
		titleLabel.attributedText = NSAttributedString(string: eventTitle, attributes: Styles.Text.EventTitleStyle)
		if let locationString = eventLocation {
			locationView.isHidden = false
			locationView.configure(locationName: locationString)
		} else {
			locationView.isHidden = true
		}
		if avatars.count > 0 {
			presenceView.isHidden = false
		} else {
			presenceView.isHidden = true
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
