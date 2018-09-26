//
//  NextWeek.swift
//  WeatherApp
//
//  Created by Bill on 9/26/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import Foundation

class NextWeek {
    private var _date: String!
    private var _minTemp: Double!
    private var _maxTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    var minTemp: Double {
        if _minTemp == nil {
            _minTemp = 0.0
        }
        return _minTemp
    }
    var maxTemp: Double {
        if _maxTemp == nil {
            _maxTemp = 0.0
        }
        return _maxTemp
    }
    
    init(weatherDictionary: Dictionary< String, AnyObject >) {
        if let minTemp = weatherDictionary["temp"] as? Dictionary<String, AnyObject> {
            if let min = minTemp["min"] as? Double {
                let rawValue = (min - 273.15).rounded()
                self._minTemp = rawValue
            }
        }
        if let maxTemp = weatherDictionary["temp"] as? Dictionary<String, AnyObject> {
            if let max = maxTemp["max"] as? Double {
                let rawValue = (max - 273.15).rounded()
                self._maxTemp = rawValue
            }
        }
        if let date = weatherDictionary["dt"] as? Double {
            let rawValue = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            self._date = "\(rawValue.dayOfTheWeek())"
        }
    }
}
