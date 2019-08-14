//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Pablo Rodriguez on 14/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import Foundation
import RxSwift

// Outputs
protocol WeatherViewModelOutputs {
    var title: String { get }
    var rows: Variable<[WeatherConditionsCellViewModel]> { get }
}

protocol WeatherViewModel {
    var outputs: WeatherViewModelOutputs { get }
}

final class WeatherViewModelImpl: WeatherViewModel {
    
    var outputs: WeatherViewModelOutputs { return self }
    
    // MARK: Properties
    
    // TODO: Modify this porperty to get the weather through an API call
    private let weather = Weather(description: "Clouds", iconString: "icon_scattered_clouds_day", temperature: 68, windSpeed: 4, windDirection: 45)
    
    // Outputs
    
    let title: String = "Weather"
    let rows = Variable<[WeatherConditionsCellViewModel]>([])
    
    // MARK: - Initialization
    
    init() {
        initRows()
    }
    
    // MARK: - Private Methods
    
    /// It initializes the rows that are going to be displayed in the table view
    private func initRows() {
        rows.value = [
            WeatherConditionsCellViewModelImpl(weather: weather, type: .conditions),
            WeatherConditionsCellViewModelImpl(weather: weather, type: .temperature),
            WeatherConditionsCellViewModelImpl(weather: weather, type: .windSpeed),
            WeatherConditionsCellViewModelImpl(weather: weather, type: .windDirection)
        ]
    }
}

extension WeatherViewModelImpl: WeatherViewModelOutputs { }
