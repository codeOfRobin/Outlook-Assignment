//
//  DayCell.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 28/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
	let dayLabel = UILabel()
	let monthLabel = UILabel()
	let stackView = UIStackView()
	// the view that shows up when you tap on a cell.
	let highlightedBackgroundView = UIView()

	override var isHighlighted: Bool {
		didSet {
			highlightedBackgroundView.isHidden = !isHighlighted
			self.dayLabel.textColor = isHighlighted ? .white : Styles.Colors.Gray.monthText.color
			self.monthLabel.textColor = isHighlighted ? .white : Styles.Colors.Gray.monthText.color
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.addSubview(stackView)
		contentView.insertSubview(highlightedBackgroundView, belowSubview: stackView)
		stackView.alignEdges(to: contentView, insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))

		stackView.axis = .vertical
		stackView.distribution = .fillEqually

		stackView.translatesAutoresizingMaskIntoConstraints = false

		monthLabel.translatesAutoresizingMaskIntoConstraints = false
		dayLabel.translatesAutoresizingMaskIntoConstraints = false

		stackView.backgroundColor = .clear

		stackView.addArrangedSubview(monthLabel)
		stackView.addArrangedSubview(dayLabel)

		self.dayLabel.textAlignment = .center
		self.monthLabel.textAlignment = .center

		highlightedBackgroundView.backgroundColor = Styles.Colors.selectedCell.color
		highlightedBackgroundView.isHidden = true

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.highlightedBackgroundView.frame = self.bounds.insetBy(dx: 4, dy: 4)
		self.highlightedBackgroundView.layer.cornerRadius = max((self.frame.width - 8)/2, (self.frame.height - 8)/2)
	}


	override func prepareForReuse() {
		super.prepareForReuse()
		highlightedBackgroundView.isHidden = true
	}

	func configure(with day: Int, month: String?, isMonthOdd: Bool) {

		// Odd and even months have different colors for contrast related reasons
		self.backgroundColor = isMonthOdd ? .white : Styles.Colors.contrastBackgroundColor.color

		if day == 1 {
			self.monthLabel.attributedText = NSAttributedString(string: month ?? "", attributes: Styles.Text.MonthTextStyle)
			// we only show the monthLabel on the first day of the month
			self.monthLabel.isHidden = false
		} else {
			self.monthLabel.isHidden = true
		}
		self.dayLabel.attributedText = NSAttributedString(string: "\(day)", attributes: Styles.Text.MonthTextStyle)

	}
}

