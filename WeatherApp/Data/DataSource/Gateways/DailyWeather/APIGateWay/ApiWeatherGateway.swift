//
//  ApiWeatherGateway.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation
import Combine

class ApiWeatherGateway: WeatherDataSource {
   
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchDailyWeather(dto: WeatherDTO) -> AnyPublisher<Weather, ApiError>{
        return apiClient.execute(request: dto,
                          returnType: ApiWeather.self)
        .print()
        .map { $0.weather }
        .eraseToAnyPublisher()
    }
}
