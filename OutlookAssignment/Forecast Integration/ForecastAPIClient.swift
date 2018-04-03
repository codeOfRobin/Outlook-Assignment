//
//  ForecastAPIClient.swift
//  OutlookAssignmentTests_iOS
//
//  Created by Robin Malhotra on 02/04/18.
//

import Foundation

struct ForecastResponse: Codable {
	let latitude: Double
	let longitude: Double
	let currentForecast: WeatherForecast

	enum CodingKeys: String, CodingKey {
		case latitude
		case longitude
		case currentForecast = "currently"
	}
}
struct WeatherForecast: Codable {
	let summary: String
	let temperature: Float
	let iconType: String

	enum CodingKeys: String, CodingKey {
		case summary
		case temperature
		case iconType = "icon"
	}

	var emojiRepresentation: String {
		switch iconType {
		case "clear-day":
			return "☀️"
		case "clear-night":
			return "🌙"
		case "rain":
			return "🌧"
		case "snow":
			return "❄️"
		case "sleet":
			return "sleet"
		case "wind":
			return "💨"
		case "fog":
			return "🌫"
		case "cloudy":
			return "☁️"
		case "partly-cloudy-day":
			return "🌤"
		case "partly-cloudy-night":
			return "☁️🌙"
		default:
			return "❓"
		}
	}
}

struct Point {
	let latitude: Double
	let longitude: Double

	var requestParams: String {
		return "\(String(describing: latitude)),\(String(describing: longitude))"
	}
}

enum Result<T> {
	case success(T)
	case failure(Error)
}

class ForecastRequestBuilder {
	enum Constants {
		static let host = "api.darksky.net"
		static let scheme = "https"
		static let forecastPath = "forecast"
	}

	// Most APIs have auth in the form of headers, but forecast's weirdness around placing the API key inside the route make this the easiest place to keep it
	let apiKey: String

	init(apiKey: String) {
		self.apiKey = apiKey
	}

	enum Route {
		case currentForecast(Point)
		case timeTravel(Point, Int)
	}

	func request(for route: Route) -> URLRequest? {
		var components = URLComponents()
		components.scheme = Constants.scheme
		components.host = Constants.host

		let path: String = {
			switch route {
			case .currentForecast(let point):
				return "/\(Constants.forecastPath)/\(apiKey)/\(point.requestParams)"
			case .timeTravel(let point, let time):
				return "/\(Constants.forecastPath)/\(apiKey)/\(point.requestParams),\(time)"
			}
		}()

		components.path = path

		return components.url.flatMap{ URLRequest(url: $0) }
	}
}

class ForecastAPIClient {

	let key: String
	let session: URLSession
	let requestBuilder: ForecastRequestBuilder

	init(session: URLSession, key: String) {
		self.session = session
		self.key = key
		self.requestBuilder = ForecastRequestBuilder(apiKey: key)
	}

	func getWeather(for point: Point, completion: @escaping (WeatherForecast) -> Void) -> URLSessionDataTask {
		let request = requestBuilder.request(for: .currentForecast(point))
		let dataTask = session.dataTask(with: request!) { (data, response, error) in
			guard (error as NSError?)?.code != -999 else {
				return
			}
			let jsonDecoder = JSONDecoder()
			do {
				let weatherResponse = try jsonDecoder.decode(ForecastResponse.self, from: data!)
				DispatchQueue.main.async {
					completion(weatherResponse.currentForecast)
				}
			} catch {

			}
		}
		dataTask.resume()
		return dataTask
	}
}
