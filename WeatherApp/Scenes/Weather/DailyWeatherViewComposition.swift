//
//  DailyWeatherViewComposition.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import Foundation
import UIKit

extension DailyWeatherView.ViewModel {
    convenience init(diContainer: DIContainer) {
        self.init(usecase: diContainer.dailyWeatherUsecase, navigator:diContainer.navigator)
    }
}

extension DIContainer {
 
    var dailyWeatherUsecase: ShowDailyWeatherUseCase {
        return DailyWeatherRepository.init(weatherDataSource: self.weatherGateways.weatherDataSource)
    }

    var navigator: DailyWeatherNavigator {
        return DailyWeatherNavigator()
    }
}


















