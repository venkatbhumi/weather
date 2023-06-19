//
//  Temparature.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation

struct Temparature: Decodable {
    @CelciusScale var temp: Double
    @CelciusScale var actualFeeling:Double
    var minimumTemp: Double
    var maximumTemp: Double
    var pressure:Int
    var humidity:Int

    enum CodingKeys: String, CodingKey {
        case temp
        case actualFeeling = "feels_like"
        case minimumTemp = "temp_min"
        case maximumTemp = "temp_max"
        case pressure
        case humidity

    }
}

struct System:Codable{

    var country:String?
    var sunrise:String?
    var sunset:String?

    enum CodingKeys: String, CodingKey {
        case country
        case sunrise
        case sunset
    }

}



