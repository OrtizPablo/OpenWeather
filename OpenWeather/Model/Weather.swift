//
//  Weather.swift
//  OpenWeather
//
//  Created by Pablo Rodriguez on 14/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import Foundation

struct Weather {
    
    // MARK: - Properties
    
    let description: String
    let iconString: String
    let temperature: Double
    let windSpeed: Double
    let windDirection: Double
    
    // MARK: - Initialization
    
    init(description: String, iconString: String, temperature: Double, windSpeed: Double, windDirection: Double) {
        self.description = description
        self.iconString = iconString
        self.temperature = temperature
        self.windSpeed = windSpeed
        self.windDirection = windDirection
    }
}

// MARK: - Decodable

extension Weather: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case weather
        case main
        case wind
    }
    
    private enum WeatherKeys: String, CodingKey {
        case main
        case icon
    }
    
    private enum MainKeys: String, CodingKey {
        case temp
    }
    
    private enum WindKeys: String, CodingKey {
        case speed
        case deg
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var weatherArrayForType = try container.nestedUnkeyedContainer(forKey: .weather)
        
        var descrptions: [String] = []
        var icons: [String] = []
        while(!weatherArrayForType.isAtEnd) {
            let weather = try weatherArrayForType.nestedContainer(keyedBy: WeatherKeys.self)
            descrptions.append(try weather.decode(String.self, forKey: .main))
            icons.append(try weather.decode(String.self, forKey: .icon))
        }
        
        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        let windContainer = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        
        let temperature = try mainContainer.decode(Double.self, forKey: .temp)
        let windSpeed = try windContainer.decode(Double.self, forKey: .speed)
        let windDirection = try windContainer.decode(Double.self, forKey: .deg)
        
        self.init(description: descrptions.first ?? "", iconString: icons.first ?? "", temperature: temperature, windSpeed: windSpeed, windDirection: windDirection)
    }
}
