

import Foundation

var latitude = Location.sharedInstance.latitude.rounded(toPlaces: 2)
var longitude = Location.sharedInstance.longitude.rounded(toPlaces: 2)
//Current Weather API + UV from darksky
let OWM_API = URL(string: "https://api.openweathermap.org/data/2.5/weather?")
let DS_API = URL(string: "https://api.darksky.net/forecast/ebec101532d63ade21f5e94ad1c75594")
//Next Week API
let FORECAST_API_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=7c609f73c5df2dff2f32e3e3cc33cd23"


typealias DownloadComplete = () -> ()

