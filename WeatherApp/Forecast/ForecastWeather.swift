/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Do Huy Hoang
 ID: s3446390
 Created date: 24/09/2018
 Acknowledgment:
 */

import Foundation
import CoreLocation


struct Weather {
    let summary: String
    let icon: String
    let temp: Double
    
    //Dictionary
    init(json:[String:Any]) throws {
        self.summary = (json["summary"] as? String)!
        self.icon = (json["icon"] as? String)!
        self.temp = (json["temperatureMax"] as? Double)!
    }
    
    //Base API path with key
    static let basePath = "https://api.darksky.net/forecast/981c19f08cbecbbb820303e09e3fd797/"
    
    //Function to get forecast information and get an array of weather objects
    static func forecast(withLocation location:CLLocationCoordinate2D, completion: @escaping([Weather]?) -> ()) {
        let url = basePath + "\(latitude),\(longitude)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            var forecastArray:[Weather] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecast = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForecast["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
                completion(forecastArray)
            }
        } 
        
        task.resume()
    }
}
