//
//  Weather.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation

struct Weather: Identifiable {
    var cityName:String?
    let id = UUID()
    var date: Int?
    var avgTemparature: Int = 0
    var pressure: Int?
    var humidity: Int?
    var description: String?
    var iconUrl: URL?
    var feelslike:Int = 0
    var visibility:Int = 0
    @StringForcible var cod: String?
    

}
