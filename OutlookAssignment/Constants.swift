//
//  Constants.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 11/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit


func style(from color: UIColor, weight: UIFont.Weight, size: CGFloat) -> [NSAttributedStringKey: Any] {
	return [
		.font: UIFont.systemFont(ofSize: size, weight: weight),
		.foregroundColor: color
	]
}

func style(from color: UIColor, font: UIFont) -> [NSAttributedStringKey: Any] {
	return [
		NSAttributedStringKey.font: font,
		NSAttributedStringKey.foregroundColor: color
	]
}

enum Constants {

	enum Strings {
		// TODO: Should this be capitalized here? or capitalize later?
		static let allDay = NSLocalizedString("ALL DAY", comment: "")
		static let noEvents = NSLocalizedString("No events", comment: "")
	}
}

enum Styles {

	enum Sizes {
		static let gutter: CGFloat = 16.0
		static let verticalInset: CGFloat = 12.0
	}

	enum Text {
		//TODO: should you have `style` at the end
		static let StartingTimeStyle = style(from: Colors.Black.defaultText.color, font: UIFont.preferredFont(forTextStyle: .subheadline))
		//TODO: or should it be like this:
		static let Duration = style(from: Colors.Gray.medium.color, font: UIFont.preferredFont(forTextStyle: .footnote))
		static let LocationStyle = style(from: .black, font: UIFont.preferredFont(forTextStyle: .subheadline))
		static let EventTitleStyle = style(from: .black, font: UIFont.preferredFont(forTextStyle: .subheadline))
		static let PlusNumberStyle = style(from: .white, font: fontWithMonospacedNumbers(UIFont.preferredFont(forTextStyle: .headline)))
		static let DateHeaderStyle = style(from: Colors.Gray.oslo.color, font: UIFont.preferredFont(forTextStyle: .callout))
		static let HighlightedDateHeaderStyle = style(from: Colors.Today.textColor.color, font: UIFont.preferredFont(forTextStyle: .callout))
		static let EmptyEventsStyle = style(from: Colors.Gray.dark.color, font: UIFont.preferredFont(forTextStyle: .subheadline))
		static let MonthTextStyle = style(from: Colors.Gray.monthText.color, font: fontWithMonospacedNumbers(UIFont.preferredFont(forTextStyle: .callout)))
	}

	enum Colors {
		enum Gray {
			static let dark = "A9A9A9"
			static let medium = "A3A3A3"
			static let oslo = "8E8E93"
			static let mediumDark = "A8A8AC"
			static let monthText = "9F9FA1"
			//TODO: BETTER NAMES
		}

		static let selectedCell = "1379D9"

		static let contrastBackgroundColor = "F8F8F8"

		enum Today {
			static let highlightBackgroundColor = "F5FAFC"
			static let textColor = "1E7CD2"
		}

		enum Black {
			static let defaultText = "1D1D1D"
		}
	}
}

extension String {

	public var color: UIColor {
		return UIColor.fromHex(self)
	}

}

