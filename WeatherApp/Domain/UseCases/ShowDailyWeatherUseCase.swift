//
//  ShowDailyWeather.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation
import Combine

protocol ShowDailyWeatherUseCase {
    var weatherDataSource:WeatherDataSource { get }
    func showDailyWeather(dto:WeatherDTO) -> AnyPublisher<Weather, ApiError>
}



