//
//  LocationProvider.swift
//  OutlookAssignment_iOS
//
//  Created by Robin Malhotra on 03/04/18.
//

import CoreLocation

protocol WeatherUpdatesDelegate: class {
	func weatherDidUpdate(_ forecast: WeatherForecast)
}

class LocationWeatherProvider: NSObject, CLLocationManagerDelegate {

	let locationManager = CLLocationManager()
	let forecastAPIClient: ForecastAPIClient

	weak var delegate: WeatherUpdatesDelegate?

	var currentRequest: URLSessionDataTask?

	init(forecastClient: ForecastAPIClient) {
		locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
		self.forecastAPIClient = forecastClient
		super.init()
		locationManager.delegate = self
	}

	func start() {
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let lastLocation = locations.last {
			// cancel the last request in case it hasn't completed
			if let request = currentRequest {
				request.cancel()
			}
			let point = Point.init(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
			self.currentRequest =  forecastAPIClient.getWeather(for: point, completion: { [weak self] (result) in
				if case .success(let forecast) = result {
					self?.delegate?.weatherDidUpdate(forecast)
				}
				// in the event of a failure, the title bar remains blank, which is a good enough compromise IMO
				self?.currentRequest = nil
			})
		}
	}
}
