//
//  NextWeek.swift
//  WeatherApp
//
//  Created by Bill on 9/25/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import Foundation

class NextWeek: Codable {
    let forecast: Forecast
}

struct Forecast: Codable {
    let weatherText: WeatherText
    
    private enum CodingKeys: String, CodingKey {
        case weatherText = "txt_forecast"
    }
}

struct WeatherText: Codable {
    let date: String
    let weekly: [Weekly]
    
    private enum CodingKeys: String, CodingKey {
        case date
        case weekly = "forecastday"
    }
}

struct Weekly: Codable {
    let imgUrl: String
    let day: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case imgUrl = "icon_url"
        case day = "title"
        case description = "fcttext"
    }
}
