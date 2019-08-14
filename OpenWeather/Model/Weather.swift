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
