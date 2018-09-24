//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Linh Do on 9/22/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import Foundation
class HourlyWeather {
    let time:String
    let icon:String
    let temp:Double
    let wind:Double
    let humidity:Double
    let uv:Int
    
    init(json:[String:Any]) {
        let date = NSDate(timeIntervalSince1970: json["time"] as! TimeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        self.time = formatter.string(from: date as Date)
        self.icon = (json["icon"] as? String)!
        self.temp = (json["temperature"] as? Double)!
        self.wind = (json["windSpeed"] as? Double)!
        self.humidity = (json["humidity"] as? Double)!
        self.uv = (json["uvIndex"] as? Int)!
    }
    
    
}

