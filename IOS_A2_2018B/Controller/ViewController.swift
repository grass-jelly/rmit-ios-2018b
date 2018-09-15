import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //Outlets
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var uvLevel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var background: UIImageView!
   
    //Constants
    let locationManager = CLLocationManager()
    
    //Variables
    var currentWeather: CurrentWeather!
    var currentLocation: CLLocation!
    
    //Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //applyEffect()
        currentWeather = CurrentWeather()
        callDelegate()
        setupLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthCheck()
    }
    
    func callDelegate() {
        locationManager.delegate = self
    }
    
    func setupLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    //Check if the user has allowed to use current location
    func locationAuthCheck() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //Get device location
            currentLocation = locationManager.location
            //Pass coordinate to API in Extras.swift
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //Check the coordinate
            print("Current latitude: ", currentLocation.coordinate.latitude)
            print("Current longitude: ",  currentLocation.coordinate.longitude)
            //Download API data of that coordinate
            currentWeather.downloadCurrentWeather {
                //Update UI after download successful
                self.updateUI()
            }
        }else{
            locationManager.requestWhenInUseAuthorization() //Ask permission again
            locationAuthCheck() //Re-check
        }
    }
    
    //Update UI
    func updateUI() {
        cityName.text = currentWeather.cityName
        temperature.text = "\(currentWeather.currentTemp)*C"
        weatherType.text = currentWeather.weatherType
        date.text = currentWeather.date
        humidity.text = "\(currentWeather.humidity)%"
        uvLevel.text = "\(currentWeather.uvLevel)"
        changeColor()
    }
    
    //Change color of text based on UV Level
    func changeColor() {
        if currentWeather.uvLevel >= 1 && currentWeather.uvLevel <= 2{
            uvLevel.textColor = UIColor.green
        }
        else if currentWeather.uvLevel >= 3 && currentWeather.uvLevel <= 5{
            uvLevel.textColor = UIColor.yellow
        }
        else if currentWeather.uvLevel >= 6 && currentWeather.uvLevel <= 7{
            uvLevel.textColor = UIColor.orange
        }
        else if currentWeather.uvLevel >= 8 && currentWeather.uvLevel <= 10{
            uvLevel.textColor = UIColor.red
        }else{
            uvLevel.textColor = UIColor.purple
        }
    }
}

