//
//  ApiClient.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation
import Combine

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol ApiRequest {
    var urlRequest: URLRequest? { get }
}

protocol ApiClient {
    func execute<T: Decodable>(request: ApiRequest, returnType: T.Type) -> AnyPublisher<T, ApiError>
}

class ApiClientImpl: ApiClient {
    let urlSession: URLSession
    
    init(urlSessionConfiguration: URLSessionConfiguration) {
        urlSession = URLSession(configuration: urlSessionConfiguration)
    }

    func execute<T: Decodable>(request: ApiRequest,
                    returnType: T.Type) -> AnyPublisher<T, ApiError> {

        guard let urlRequest =  request.urlRequest else {
            return Empty().eraseToAnyPublisher()

        }
        print(urlRequest.url ?? "")
       return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: returnType.self, decoder: JSONDecoder())
            .mapError({ (error) -> ApiError in
                 ApiError(error: error,
                                data: nil,
                                httpUrlResponse: nil)
            })
            .eraseToAnyPublisher()
    }
}
