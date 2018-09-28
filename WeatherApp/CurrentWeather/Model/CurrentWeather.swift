/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Vu Hong Lan
 ID: s3557614
 Created date: 22/09/2018
 Acknowledgment:
 API:
 1/ https://openweathermap.org/current
 2/ https://darksky.net/dev
 CurrentWeather + Obtain API + Format to display in UI:
 1/ https://www.youtube.com/watch?v=BrWbRgacHKo
 2/ https://www.youtube.com/watch?v=JHAL17hP7YY
 3/ https://www.youtube.com/watch?v=98e77NwfXjM
 Timer:
 https://stackoverflow.com/questions/25951980/do-something-every-x-minutes-in-swift
 Search Location - Google Maps
 1/https://developers.google.com/places/ios-sdk/autocomplete#add_a_results_controller
 2/https://medium.freecodecamp.org/how-you-can-use-the-google-maps-sdk-with-ios-using-swift-4-a9bba26d9c4d
 */

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeather {
    
    //Variable
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    private var _humidity: Double!
    private var _uvLevel: Int!
    private var _windGust: Double!
    private var _windSpeed: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var humidity: Double {
        if _humidity == nil {
            _humidity = 0.0
        }
        return _humidity
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var uvLevel: Int {
        if _uvLevel == nil {
            _uvLevel = 0
        }
        return _uvLevel
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var windGust: Double {
        if _windGust == nil {
            _windGust = 0.0
        }
        return _windGust
    }
    
    var windSpeed: Double {
        if _windSpeed == nil {
            _windSpeed = 0.0
        }
        return _windSpeed
    }
    
    func downloadCurrentWeather(completed: @escaping DownloadComplete){
        //Other weather data
        if let API_URL = URL(string: "\(OWM_API!)lat=\(latitude)&lon=\(longitude)&appid=a5967430197a9f35b3b6ba8165537990"){
            Alamofire.request(API_URL).responseJSON{ (response) in
                //print("OpenWeatherMap:", response) //Uncomment if you want to check content of OpenWeatherMap API
                let result = response.result
                let json = JSON(result.value)
                //Get city's name
                self._cityName = json["name"].stringValue
                //Get date and convert it to correct format
                let tempDate = json["dt"].double
                let convertedDate = Date(timeIntervalSince1970: tempDate!)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                let currentDate = dateFormatter.string(from: convertedDate)
                self._date = "\(currentDate)"
                //Get weather type
                self._weatherType = json["weather"][0]["main"].stringValue
                //Get current temp
                let downloadedTemp = json["main"]["temp"].double
                self._currentTemp = downloadedTemp! - 273.15
                //Get humidity
                let downloadedHumidity = json["main"]["humidity"].double
                self._humidity = downloadedHumidity!
                completed()
            }
        }
        //UV Level
        if let DarkSky_API_URL = URL(string: "\(DS_API!)/\(latitude),\(longitude)"){
            Alamofire.request(DarkSky_API_URL).responseJSON{ (response) in
                let darkSkyResult = response.result
                //print("Darksky:", response) //Uncomment if you want to view the detail of this API
                //Get uvIndex
                let json = JSON(darkSkyResult.value)
                let downloadedUV = json["currently"]["uvIndex"].int
                self._uvLevel = downloadedUV!
                //Get wind gust
                let downloadedWindGust = json["currently"]["windGust"].double?.rounded(toPlaces: 2)
                self._windGust = downloadedWindGust!
                //Get wind speed
                let downloadedWindSpeed = json["currently"]["windSpeed"].double?.rounded(toPlaces: 1)
                self._windSpeed = downloadedWindSpeed!
            }
        }
    }
}
