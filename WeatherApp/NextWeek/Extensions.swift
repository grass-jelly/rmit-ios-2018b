//
//  Extensions.swift
//  WeatherApp
//
//  Created by Bill on 9/26/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//
import Foundation

extension Double{
    //Round the double to decimal value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date{
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
