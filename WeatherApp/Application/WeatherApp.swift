//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import SwiftUI

@main
struct WeatherApp: App {
    var navigator:DailyWeatherNavigator = DailyWeatherNavigator()
    var body: some Scene {
        WindowGroup {
            EmptyView()
                .onAppear{
                    navigator.show()
            }
        }

        }
    }



