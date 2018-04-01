//
//  AttendeesView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 18/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class AttendeesView: UIView {
	private var circles: [CircularAvatar] = []
	let margin: CGFloat = 8

	// might as well initialize it cos you're gonna need it for sizing later
	let plusNumberView = PlusNumberView(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(plusNumberView)
	}


	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		let circleEdge = plusNumberView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).height
		return CGSize(width: size.width, height: circleEdge)
	}

	override var intrinsicContentSize: CGSize {
		let circleEdge = plusNumberView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).height
		return CGSize(width: CGFloat(circles.count) * (margin + circleEdge), height: circleEdge)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		let frame = self.frame

		let circleEdge = plusNumberView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).height

		let numberOfAvatarsToFit = Int((frame.width - margin)/(circleEdge + margin))

		circles.enumerated().forEach { arg in
			let (index, circle) = arg
			circle.translatesAutoresizingMaskIntoConstraints = true
			circle.frame = CGSize(width: circleEdge, height: circleEdge).centeredVertically(in: self.bounds, left: frame.minX + CGFloat(index) * (circleEdge + margin))
			circle.alpha = (index >= numberOfAvatarsToFit - 1) ? 0.0 : 1.0
		}

		let extraAvatars = circles.count - numberOfAvatarsToFit

		self.plusNumberView.alpha = extraAvatars > 0 ? 1.0 : 0.0

		if extraAvatars > 0 && numberOfAvatarsToFit > 0 {
			plusNumberView.translatesAutoresizingMaskIntoConstraints = true
			plusNumberView.configure(with: circles.count - numberOfAvatarsToFit + 1)
			let leftover = self.frame.width - CGFloat(numberOfAvatarsToFit) * circleEdge
			let lastCircleFrame = (circles.prefix(numberOfAvatarsToFit - 1).last?.frame ?? .zero)
			let plusNumberSize = plusNumberView.sizeThatFits(CGSize.init(width: leftover, height: circleEdge))
			plusNumberView.frame = plusNumberSize.centeredVertically(in: self.bounds, left: lastCircleFrame.maxX + margin)
		}

	}

	func configure(with avatars: [Attendee.Avatar]) {

		self.circles.forEach { $0.removeFromSuperview() }
		let newCircles: [CircularAvatar] = avatars.flatMap { (avatar) in
			switch avatar {
			case .image(let image):
				return CircularAvatar(image: image)
			case .initials(let char1, let char2):
				return nil
			}
		}

		newCircles.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		newCircles.forEach { self.addSubview($0) }
		self.circles = newCircles
		self.setNeedsLayout()
	}
}
