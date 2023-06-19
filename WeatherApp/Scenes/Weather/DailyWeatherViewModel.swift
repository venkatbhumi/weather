//
//  DailyWeatherViewModel.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import Foundation
import Combine
import CoreLocation
import UIKit
import SwiftUI

extension DailyWeatherView {

    final class ViewModel: ObservableObject {

        private var cancellable = Set<AnyCancellable>()
        private let activityTracker = ActivityTracker(false)
        private var errorTracker = ErrorTracker()
        var usecase: ShowDailyWeatherUseCase
        var navigator: DailyWeatherNavigator

        // INPUT
        @Published var citySearchText: String = ""
        @Published var locationManager = LocationManager()
        @Published var showMoreTrigger = false

        // OUTPUT
        @Published  var dailyWeather: Weather = Weather.init()
        @Published var isLoading: Bool = false
        @Published var isValidSearch: Bool = true
        @Published var alert = AlertMessage()

        init(usecase: ShowDailyWeatherUseCase,navigator:DailyWeatherNavigator) {
            self.usecase = usecase
            self.navigator = navigator
            locationManager.requestLocation()

            locationManager.location.sink { [weak self] _location in
                guard let function = WeatherFunction.cordinates(_location).value else{
                    return
                }
                self?.loadWeather(function:function)
            }.store(in: &cancellable)

            $citySearchText
                .map({
                    return WeatherFunction.cityOrZipCode($0).value ?? ""
                })
                .filter { $0.count > 3 }
                .sink(receiveValue: loadWeather(function:))
                .store(in: &cancellable)

            activityTracker
                .receive(on: DispatchQueue.main)
                .assign(to: \.isLoading, on: self)
                .store(in: &cancellable)
            errorTracker
                .receive(on: DispatchQueue.main)
                .compactMap { AlertMessage(error: ($0 as? ApiError)) }
                .assign(to: \.alert, on: self)
                .store(in: &cancellable)

            $showMoreTrigger
                .filter({$0==true})
                .sink(receiveValue: { [weak self] value in
                    guard let weather = self?.dailyWeather else {
                        return
                    }
                    self?.navigator.showDetails(weather: weather)
                })
                .store(in: &cancellable)

        }

        private func loadWeather(function: String) {
            self.usecase.showDailyWeather(dto: WeatherDTO(function: function))
                .trackActivity(activityTracker)
                .trackError(errorTracker)
                .replaceError(with:Weather())
                .receive(on: RunLoop.main)
                .assign(to: \.dailyWeather, on: self)
                .store(in: &cancellable)
        }

    }
}

extension DailyWeatherView{
      
    }


public enum WeatherFunction{

    case cityOrZipCode(String)
    case cordinates(CLLocationCoordinate2D?)


    var value:String?{
        switch self{
        case .cityOrZipCode(let city):
            return "q=\(city)"

        case .cordinates(let cor):
           
            return "lat=\(cor?.latitude ?? 0.0)&lon=\(cor?.latitude ?? 0.0)"
        }
    }

}
