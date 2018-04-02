//
//  ForecastAPIClient.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 02/04/18.
//

import Foundation

struct WeatherForecast: Codable {
	let summary: String
	let temperature: Float
}

struct Point {
	let latitude: Double
	let longitude: Double
}

class ForecastAPIClient {

	let key: String
	let session: URLSession

	let baseURL = "https://api.darksky.net/"

	init(session: URLSession, key: String) {
		self.session = session
		self.key = key
	}

	func getWeather(for: Point, completion: @escaping (WeatherForecast) -> Void) {
		
	}
}
