//
//  EventTableViewCell.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 13/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

	let stackView = UIStackView()
	let timingView = EventTimingView(frame: .zero)
	let rightLabel = UILabel()


	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.contentView.addSubview(stackView)
		self.rightLabel.numberOfLines = 0
		self.stackView.addArrangedSubview(timingView)
		self.stackView.addArrangedSubview(rightLabel)

		// Disabling this doesn't have broken constraints, but splits the width between 2 views
		self.stackView.distribution = .fillProportionally

		NSLayoutConstraint.activate([
			self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0),
			self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0),
			self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0),
			self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12.0),
			])

		self.stackView.translatesAutoresizingMaskIntoConstraints = false
	}

	func configure(with event: EventViewModel) {
		//Simulating a larger event title
		self.rightLabel.text = event.title + event.title + event.title
		self.timingView.configure(with: event.timing)
	}


	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}



