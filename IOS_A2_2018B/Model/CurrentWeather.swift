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
    
    func downloadCurrentWeather(completed: @escaping DownloadComplete){
        //Other weather data
        Alamofire.request(API_URL).responseJSON{ (response) in
            print(response)
            let result = response.result
            print(result)
            let json = JSON(result.value)
            self._cityName = json["name"].stringValue
            let tempDate = json["dt"].double
            let convertedDate = Date(timeIntervalSince1970: tempDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: convertedDate)
            self._date = "\(currentDate)"
            print(currentDate)
            self._weatherType = json["weather"][0]["main"].stringValue
            let downloadedTemp = json["main"]["temp"].double
            self._currentTemp = downloadedTemp! - 273.15
            let downloadedHumidity = json["main"]["humidity"].double
            self._humidity = downloadedHumidity!
            completed()
        }
        //UV Level
        Alamofire.request(UV_API_URL).responseJSON{ (response) in
            print(response)
            let uvResult = response.result
            print(uvResult)
            let json = JSON(uvResult.value)
            let downloadedUV = json["currently"]["uvIndex"].int
            self._uvLevel = downloadedUV!
        }
    }
}
