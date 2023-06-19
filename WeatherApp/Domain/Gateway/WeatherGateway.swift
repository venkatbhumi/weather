//
//  WeatherGateway.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation
import Combine

protocol WeatherDataSource {
    func fetchDailyWeather(dto:WeatherDTO) -> AnyPublisher<Weather, ApiError>
}
