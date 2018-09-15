

import Foundation

let API_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=a5967430197a9f35b3b6ba8165537990"
//let UV_API_URL = "https://api.openweathermap.org/data/2.5/uvi?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=a5967430197a9f35b3b6ba8165537990"
let UV_API_URL = "https://api.darksky.net/forecast/ebec101532d63ade21f5e94ad1c75594/\(Location.sharedInstance.latitude!),\(Location.sharedInstance.longitude!)"
typealias DownloadComplete = () -> ()

