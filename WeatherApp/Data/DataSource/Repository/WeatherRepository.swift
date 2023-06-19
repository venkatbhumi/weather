//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import Foundation
import Combine


protocol _DailyWeatherRepository{
    func showDailyWeather(dto:WeatherDTO) -> AnyPublisher<Weather, ApiError>
}





class DailyWeatherRepository:ShowDailyWeatherUseCase {
    let weatherDataSource: WeatherDataSource

    init(weatherDataSource: WeatherDataSource) {
        self.weatherDataSource = weatherDataSource
    }
    func showDailyWeather(dto:WeatherDTO) -> AnyPublisher<Weather, ApiError> {
        return self.weatherDataSource.fetchDailyWeather(dto:dto)
            .eraseToAnyPublisher()
    }

}
