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

		startingTimeLabel.numberOfLines = 0
		durationLabel.numberOfLines = 0
		self.addSubview(startingTimeLabel)
		self.addSubview(durationLabel)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		let startingTimeIntrinsicSize = startingTimeLabel.intrinsicContentSize
		let startingTimeSize = startingTimeLabel.sizeThatFits(CGSize(width: min(frame.size.width, startingTimeIntrinsicSize.width), height: CGFloat.greatestFiniteMagnitude))
		let durationIntrinsicSize = durationLabel.intrinsicContentSize
		let durationSize = durationLabel.sizeThatFits(CGSize(width: min(frame.size.width, durationIntrinsicSize.width), height: CGFloat.greatestFiniteMagnitude))
		startingTimeLabel.frame = CGRect(origin: .zero, size: startingTimeSize)
		durationLabel.frame = CGRect(x: 0, y: startingTimeLabel.frame.maxY + margin, width: durationSize.width, height: durationSize.height)
	}

	override var intrinsicContentSize: CGSize {
		return self.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		let startingTimeIntrinsicSize = startingTimeLabel.intrinsicContentSize
		let startingTimeSize = startingTimeLabel.sizeThatFits(CGSize(width: min(frame.size.width, startingTimeIntrinsicSize.width), height: CGFloat.greatestFiniteMagnitude))
		let durationIntrinsicSize = durationLabel.intrinsicContentSize
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
		case .timed(startingTime: let startingTime, duration: let duration):
			self.startingTimeLabel.attributedText = NSAttributedString(string: startingTime, attributes: Styles.Text.StartingTimeStyle)
			self.durationLabel.attributedText = NSAttributedString(string: duration, attributes: Styles.Text.Duration)
		}
	}
}
