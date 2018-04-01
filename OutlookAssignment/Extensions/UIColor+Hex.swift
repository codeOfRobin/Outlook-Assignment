//
//  UIColor+Hex.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 11/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

extension UIColor {

	// http://stackoverflow.com/a/27203691/940936
	public static func fromHex(_ hex: String) -> UIColor {
		var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

		if cString.hasPrefix("#") {
			cString.remove(at: cString.startIndex)
		}

		if cString.count != 6 {
			return .gray
		}

		var rgbValue: UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)

		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}

}
