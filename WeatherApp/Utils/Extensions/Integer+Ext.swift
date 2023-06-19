//
//  Integer+Ext.swift
//  weather-app
//
//  Created by Anil on 2023
//

import Foundation

extension Int {
    func convertToFormat() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "E, dd MMM yyyy, HH:mm a"
        return dateFormatter.string(from: date)
    }
}
