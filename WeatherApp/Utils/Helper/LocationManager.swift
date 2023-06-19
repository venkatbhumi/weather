//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import Foundation
import Combine
import CoreLocation

public class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    public let manager = CLLocationManager()

     var location = PassthroughSubject<CLLocationCoordinate2D?,Never>()

    public override init() {
        super.init()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    public func requestLocation() {
        manager.requestLocation()

    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location.send(locations.first?.coordinate)

    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error:: \(error.localizedDescription)")
       }
}
