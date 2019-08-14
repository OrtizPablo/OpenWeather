//
//  WeatherConditionsCellViewModel.swift
//  OpenWeather
//
//  Created by Pablo Rodriguez on 14/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import UIKit

enum WeatherConditionType {
    case conditions, temperature, windSpeed, windDirection
    
    var title: String {
        switch self {
        case .conditions: return "Conditions:"
        case .temperature: return "Temperature:"
        case .windSpeed: return "Wind Speed:"
        case .windDirection: return "Wind Direction:"
        }
    }
    
    var shouldShowImage: Bool {
        switch self {
        case .conditions: return true
        case .temperature, .windSpeed, .windDirection: return false
        }
    }
    
    func conditionText(weather: Weather) -> String {
        switch self {
        case .conditions: return weather.description
        case .temperature: return String(convertFarenheitToCelsius(temperature: weather.temperature)) + "°C"
        case .windSpeed: return String(weather.windSpeed) + "mph"
        case .windDirection: return convertDegreesToDirection(degrees: weather.windDirection)
        }
    }
    
    /// It converts the farenheit degrees into celsius degrees
    ///
    /// - Parameter temperature: temperature in farenheit degrees
    /// - Returns: An integer of the temperature in celsius degrees
    private func convertFarenheitToCelsius(temperature: Double) -> Int {
        return Int((temperature - 32) * 5 / 9)
    }
    
    /// It converts degrees into a cardinal direction
    ///
    /// - Parameter degrees: degrees to be converted
    /// - Returns: the cardinal direction string
    private func convertDegreesToDirection(degrees: Double) -> String {
        if degrees >= 45 && degrees < 135 {
            return "East"
        } else if degrees >= 135 && degrees < 225 {
            return "South"
        } else if degrees >= 225 && degrees < 315 {
            return "west"
        } else {
            return "North"
        }
    }
    
    func image(of weather: Weather) -> UIImage? {
        switch self {
        case .conditions: return UIImage(named: weather.iconString)
        case .temperature, .windSpeed, .windDirection: return nil
        }
    }
}

// Outputs
protocol WeatherConditionsCellViewModelOutputs {
    var title: String { get }
    var conditionText: String { get }
    var image: UIImage? { get }
    var shouldShowImage: Bool { get }
}

protocol WeatherConditionsCellViewModel {
    var outputs: WeatherConditionsCellViewModelOutputs { get }
}

final class WeatherConditionsCellViewModelImpl: WeatherConditionsCellViewModel {
    
    var outputs: WeatherConditionsCellViewModelOutputs { return self }
    
    // MARK: - Properties
    
    private let weather: Weather
    private let type: WeatherConditionType
    
    // Outputs
    
    var title: String { return type.title }
    var conditionText: String { return type.conditionText(weather: weather) }
    var image: UIImage? { return type.image(of: weather) }
    var shouldShowImage: Bool { return type.shouldShowImage }
    
    // MARK: - Initialization
    
    init(weather: Weather, type: WeatherConditionType) {
        self.weather = weather
        self.type = type
    }
}

extension WeatherConditionsCellViewModelImpl: WeatherConditionsCellViewModelOutputs { }
