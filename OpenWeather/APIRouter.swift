//
//  APIRouter.swift
//  OpenWeather
//
//  Created by Pablo Rodriguez on 14/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import Foundation
import PromiseKit

protocol APIRouter {
    
}

final class WeatherRouter: APIRouter {
    
    private let backendManager: BackendManager
    
    init(backendManager: BackendManager) {
        self.backendManager = backendManager
    }
}
