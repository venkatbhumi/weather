//
//  ApiDailyWeather.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation

struct ApiDailyWeather: Decodable {
    var list: ApiWeather
}
