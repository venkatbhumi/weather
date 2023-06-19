//
//  ErrorTracker.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import Combine

public typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher where Failure: Error {
    public func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}
