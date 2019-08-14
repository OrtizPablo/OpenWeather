//
//  BackendManager.swift
//  OpenWeather
//
//  Created by Pablo Rodriguez on 14/08/2019.
//  Copyright © 2019 Pablo Ortiz Rodriguez. All rights reserved.
//

import Foundation
import PromiseKit

struct APIRequest {
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey: [String: String] = ["APPID": "ead66ccfbe48807008a25600ce8fb1f9"]
    let parameters: [String: Any]?
}

enum RequestError: Error {
    case unknownURL
    case clientError
    case serverError
    
    var localizedDescription: String {
        switch self {
        case .unknownURL: return "URL unknown"
        case .clientError: return "Client error"
        case .serverError: return "Server error"
        }
    }
}

protocol BackendManager {
    func execute<T: Decodable>(apiRequest: APIRequest) -> Promise<T>
}

final class WeatherBackendManager: BackendManager {
    
    /// Function that will make the API calls in the app.
    ///
    /// - Parameter apiRequest: Content of the API Request
    /// - Returns: a promise with the data fetched from the API call
    func execute<T: Decodable>(apiRequest: APIRequest) -> Promise<T> {
        return Promise { seal in
            var urlComponents = URLComponents(string: apiRequest.baseURL)
            var parameters: [URLQueryItem] = []
            if let requestParameters = apiRequest.parameters {
                for (key, value) in requestParameters {
                    let value = String(describing: value)
                    parameters.append(URLQueryItem(name: key, value: value))
                }
            }
            for (key, value) in apiRequest.apiKey {
                parameters.append(URLQueryItem(name: key, value: value))
            }
            urlComponents?.queryItems = parameters
            guard let url = urlComponents?.url else { return seal.reject(RequestError.unknownURL) }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return seal.reject(RequestError.clientError)
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    return seal.reject(RequestError.serverError)
                }
                
                do {
                    let value = try JSONDecoder().decode(T.self, from: data)
                    seal.fulfill(value)
                } catch {
                    return seal.reject(error)
                }
            }.resume()
        }
    }
}
