//
//  ApiWeather.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation

struct ApiWeather: Decodable {
    var dt: Int?
    var temp: Temparature?
    var weatherDetail: [WeatherDetail]?
    var name:String?
    var visibility:Int?
   // var system:System?
    @StringForcible var cod: String?

    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp = "main"
        case weatherDetail = "weather"
        case name
        case visibility
        case cod
      //  case system = "sys"
    }
}

extension ApiWeather {
    var weather: Weather {
        let cityName = self.name
        let weatherIcon = weatherDetail?.first?.icon
        let weatherDesc = weatherDetail?.first?.description
        let iconUrl = URL(string: "\(AppConstants.apiBaseURL)/img/w/\(weatherIcon ?? "").png")
        return .init(cityName:cityName,date: dt,
                     avgTemparature: Int(temp?.temp ?? 0),
                     pressure: temp?.pressure,
                     humidity: temp?.humidity,
                     description: weatherDesc,
                     iconUrl: iconUrl,feelslike:Int(temp?.actualFeeling ?? 0) ,visibility: self.visibility ?? 0,cod: self._cod)
    }
}

@propertyWrapper
struct StringForcible: Codable {

    var wrappedValue: String?

    enum CodingKeys: CodingKey {}

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            wrappedValue = string
        } else if let integer = try? container.decode(Int.self) {
            wrappedValue = "\(integer)"
        } else if let double = try? container.decode(Double.self) {
            wrappedValue = "\(double)"
        } else if container.decodeNil() {
            wrappedValue = nil
        }
        else {
            throw DecodingError.typeMismatch(String.self, .init(codingPath: container.codingPath, debugDescription: "Could not decode incoming value to String. It is not a type of String, Int or Double."))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }

    init() {
        self.wrappedValue = nil
    }

}


@propertyWrapper
struct CelciusScale:Codable {

    var wrappedValue: Double = 0.0


    enum CodingKeys: CodingKey {}

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let dbl = try? container.decode(Double.self) {
            wrappedValue = (dbl - 273.0)
        }
        if let dbl = try? container.decode(Int
            .self) {
            wrappedValue = (Double(dbl) - 273.0)
        }

    }
}
