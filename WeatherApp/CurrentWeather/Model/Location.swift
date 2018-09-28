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

//Manage Longitude Latitude
class Location {
    
    static var sharedInstance = Location()

    var longitude: Double!
    var latitude: Double!
    
}
