//
//  WeatherDetailsNavigator.swift
//  WeatherApp
//
//  Created by Rakesh Kumar Biswal on 03/02/23.
//

import Foundation
import UIKit
import SwiftUI

protocol WeatherDetailsNavigatorType:MainNavigatorType {
     func showDetails(weather:Weather)
     var navigationController: UINavigationController? { get  }

}

struct WeatherDetailsNavigator: WeatherDetailsNavigatorType {
    var navigationController: UINavigationController?{
        window?.rootViewController as? UINavigationController
    }


    func showDetails(weather: Weather) {
        let view = WeatherDetailsView()
        let vc = UIHostingController(rootView: view)
        navigationController?.pushViewController(vc, animated: true)

    }


}

