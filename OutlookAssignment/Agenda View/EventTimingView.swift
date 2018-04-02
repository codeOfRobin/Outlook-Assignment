//
//  EventTimingView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 13/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit


class EventTimingView: UIView {
	let startingTimeLabel = UILabel()
	let durationLabel = UILabel()
	let margin: CGFloat = 8

	override init(frame: CGRect) {
		super.init(frame: frame)

		// A value of 0 means no limit on the number of lines
		startingTimeLabel.numberOfLines = 0
		durationLabel.numberOfLines = 0
		self.addSubview(startingTimeLabel)
		self.addSubview(durationLabel)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// This view is manually laid out due to UIStackView shenanigans (I emailed Ogden about these early on)
	override func layoutSubviews() {
		super.layoutSubviews()

		// calculate how much space (upto the frame width) the starting time label will take
		let startingTimeIntrinsicSize = startingTimeLabel.intrinsicContentSize
		// calculate the height using the width and `sizeThatFits`
		let startingTimeSize = startingTimeLabel.sizeThatFits(CGSize(width: min(frame.size.width, startingTimeIntrinsicSize.width), height: CGFloat.greatestFiniteMagnitude))

		// figure out how much space (upto the frame width) the starting time label will take
		let durationIntrinsicSize = durationLabel.intrinsicContentSize
		// calculate the height using the width and `sizeThatFits`
		let durationSize = durationLabel.sizeThatFits(CGSize(width: min(frame.size.width, durationIntrinsicSize.width), height: CGFloat.greatestFiniteMagnitude))

		// now actually layout the views
		startingTimeLabel.frame = CGRect(origin: .zero, size: startingTimeSize)
		durationLabel.frame = CGRect(x: 0, y: startingTimeLabel.frame.maxY + margin, width: durationSize.width, height: durationSize.height)
	}

	override var intrinsicContentSize: CGSize {
		return self.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {

		// calculate how much space (upto the frame width) the starting time label will take
		let startingTimeIntrinsicSize = startingTimeLabel.intrinsicContentSize
		// calculate the height using the width and `sizeThatFits`
		let startingTimeSize = startingTimeLabel.sizeThatFits(CGSize(width: min(frame.size.width, startingTimeIntrinsicSize.width), height: CGFloat.greatestFiniteMagnitude))

		// calculate how much space (upto the frame width) the starting time label will take
		let durationIntrinsicSize = durationLabel.intrinsicContentSize
		// calculate the height using the width and `sizeThatFits`
		let durationSize = durationLabel.sizeThatFits(CGSize(width: min(frame.size.width, durationIntrinsicSize.width), height: CGFloat.greatestFiniteMagnitude))
		if durationSize == .zero {
			return CGSize(width: max(startingTimeSize.width, durationSize.width), height: startingTimeSize.height)
		} else {
			return CGSize(width: max(startingTimeSize.width, durationSize.width), height: startingTimeSize.height + margin + durationSize.height)
		}
	}

	func configure(with timing: EventViewModel.EventTiming) {
		switch timing {
		case .allDay:
			self.startingTimeLabel.attributedText = NSAttributedString(string: Constants.Strings.allDay, attributes: Styles.Text.StartingTimeStyle)
			self.durationLabel.isHidden = true
		case .timed(startingTime: let startingTime, duration: let duration):
			self.startingTimeLabel.attributedText = NSAttributedString(string: startingTime, attributes: Styles.Text.StartingTimeStyle)
			self.durationLabel.attributedText = NSAttributedString(string: duration, attributes: Styles.Text.Duration)
		}
	}
}
