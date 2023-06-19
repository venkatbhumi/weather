//
//  WeatherDailyRequest.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation



struct WeatherDTO:Encodable{
    let function: String
}

extension WeatherDTO :ApiRequest {
    var urlRequest: URLRequest? {
        let query = "\(self.function)"
        let str = "\(AppConstants.apiBaseURL)/data/2.5/weather?" +
        "\(query)&" +
        "appid=\(AppConstants.apiKey)"
        guard let url = URL(string:str ) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
}




func getBalanced(str:String) -> Bool{
    var stack = [String]()
    let dict:[String:String] = ["(":")","{":"}","[":"]"]
    let charArray = Array(str)


    for index in 0...charArray.count{
        if let ele = stack.last,dict[ele] == "\(charArray[index])"{
            stack.removeLast()
        }else{
            stack.append("\(charArray[index])")
        }
    }

    return stack.isEmpty


}















