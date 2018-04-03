//
//  Attendee.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 13/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

struct Attendee {
	let name: String

	enum Avatar {
		case image(UIImage)
//			Considered adding initials support at some point, but scrapped it later. Would let you specify a couple of initials and a background color, and would generate an avatar for you
		//initials are really just 1-2 characters
//		case initials(Character, Character?)
	}

	let avatar: Avatar
}
