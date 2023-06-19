//
//  GatewayComposition.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import Foundation

final class Gateways {
    lazy var weatherDataSource: WeatherDataSource = {
        let apiClient = ApiClientImpl(urlSessionConfiguration: .default)
        return ApiWeatherGateway(apiClient: apiClient)
    }()
}



