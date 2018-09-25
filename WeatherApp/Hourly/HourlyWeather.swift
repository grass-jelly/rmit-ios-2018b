/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Linh Do
 ID: 3689251
 Created date: 22/09/2018
 Acknowledgment:
 */

import Foundation
class HourlyWeather {
    let time:String
    let icon:String
    let temp:Double
    let wind:Double
    let humidity:Double
    let uv:Int
    
    init(json:[String:Any], timezone:String) {
        let date = NSDate(timeIntervalSince1970: json["time"] as! TimeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.timeZone = TimeZone.init(identifier: timezone)
        self.time = formatter.string(from: date as Date)
        
        self.icon = (json["icon"] as? String)!
        self.temp = (json["temperature"] as? Double)!
        self.wind = (json["windSpeed"] as? Double)!
        self.humidity = (json["humidity"] as? Double)!
        self.uv = (json["uvIndex"] as? Int)!
    }
    
    
    
    
}

