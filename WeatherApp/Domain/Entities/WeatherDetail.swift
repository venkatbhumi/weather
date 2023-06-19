//
//  WeatherDetail.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation

struct WeatherDetail: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
