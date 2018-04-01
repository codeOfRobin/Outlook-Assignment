//
//  Collection+ElementAtIndex.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 01/04/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation

extension Collection {
	func element(at offset: IndexDistance) -> Element? {
		let optionalIndex = self.index(self.startIndex, offsetBy: offset, limitedBy: endIndex)
		guard let index = optionalIndex else { return nil }
		return self[index]
	}
}
