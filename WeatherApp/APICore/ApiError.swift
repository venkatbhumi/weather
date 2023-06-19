//
//  ApiError.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation

struct ApiError: Error {
    static let code = 999
    
    let error: Error?
    let data: Data?
    let httpUrlResponse: HTTPURLResponse?
    
    var localizedMessage: String {
        guard let response = httpUrlResponse else {
            return (error?.localizedDescription) ?? "Please type an invalid name"
        }
        
        switch response.statusCode {
        case 404: return "Nooo! Bad luck, resource not found!"
        default: return "Oh, Something wrong, please try again..."
        }
    }
     var badUrl:String{
        return "Invalid URL"
    }
}
