//
//  WindowNavigation.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import Foundation
import Combine
import SwiftUI
import UIKit



open class Navigation: ObservableObject {
    let window: UIWindow?


    public init(window: UIWindow?) {
        self.window = window
    }
}


public class Applications{

    static var appWindow:UIWindow? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }

    static public var appNavigation:Navigation{
        Navigation(window: appWindow)
    }

    static func pushViewController(vc:UIViewController,animated: Bool = true){
        //if let vc = appWindow?.rootViewController{
           // nav.pushViewController(vc, animated: true)
        //}

    }


}





extension UIApplication {

    var appWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }

}
