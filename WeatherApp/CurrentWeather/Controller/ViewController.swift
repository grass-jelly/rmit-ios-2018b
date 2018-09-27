import UIKit
import CoreLocation
import GoogleMaps
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    //Outlets
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var uvLevel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windGust: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureSwitch: UISwitch!
    
//Constants
    let locationManager = CLLocationManager()
    let hour = Calendar.current.component(.hour, from: Date())
    let geocoder = CLGeocoder()

//Variables
    var currentWeather: CurrentWeather!
    var currentLocation: CLLocation!
    var placemark: CLPlacemark?
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
//Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        changeBGImg()
        currentWeather = CurrentWeather()
        callDelegate()
        setupLocation()
        searchCityName()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        locationAuthCheck()
        searchCityName()
    }
    
    func callDelegate() {
        locationManager.delegate = self
    }
    
//*********Search Bar*********//
    //Search City Name
    func searchCityName(){
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self as? GMSAutocompleteResultsViewControllerDelegate
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        //UISearchController present the results in this view controller
        definesPresentationContext = true
    }
    
//*************Location Functions************//
    //Setup current location + ask for permission
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
            //Set condition to prevent error
            if let loc = locationManager.location {
                //Pass coordinate to API in Extras.swift
                Location.sharedInstance.latitude = currentLocation.coordinate.latitude
                Location.sharedInstance.longitude = currentLocation.coordinate.longitude
                //Download API data of that coordinate
                currentWeather.downloadCurrentWeather {
                    //Update UI after download successful
                    self.updateUI()
                }
            }
        }else{
            locationManager.requestWhenInUseAuthorization() //Ask permission again
            locationAuthCheck() //Re-check
        }
    }
    
//*****************UI Functions******************//
    
    //Update UI
    func updateUI() {
        cityName.text = currentWeather.cityName
        temperature.text = "\(currentWeather.currentTemp)°C"
        weatherType.text = currentWeather.weatherType
        date.text = currentWeather.date
        humidity.text = "Humidity: \(currentWeather.humidity)%"
        uvLevel.text = "UV: \(currentWeather.uvLevel)"
        changeColor()
        changeWeatherIcon()
    }
    
    //Change Background based on current time
    func changeBGImg(){
        if hour >= 18 || hour <= 5 {
            background.image = UIImage(named: "nightTIme")
            cityName.textColor = UIColor.white
        }
        else {
            background.image = UIImage(named: "cloudBG")
        }
    }
    
    //Change color of text based on UV Level
    func changeColor() {
        if currentWeather.uvLevel >= 0 && currentWeather.uvLevel <= 2{
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
    
    //Change Weather Icon
    func changeWeatherIcon() {
        //Update Icon Based on Weather Type
        if weatherType.text == "Rain" {
            weatherIcon.image = UIImage(named: "rain")
        } else if weatherType.text == "Thunderstorm"{
            weatherIcon.image = UIImage(named: "thunderstorm")
        } else if weatherType.text == "Clear"{
            weatherIcon.image = UIImage(named: "sunny")
        } else if weatherType.text == "Clouds"{
            weatherIcon.image = UIImage(named: "cloudy")
        } else if weatherType.text == "Drizze"{
            weatherIcon.image = UIImage(named: "drizzle")
        } else if weatherType.text == "Snow" {
            weatherIcon.image = UIImage(named: "snow")
        }
    }
    
    //Convert Celsius to Fahrenheit and the opposite
    static func convertFahrenheit(temperature: Double) -> Double{
        let fahrenheit = temperature * 9 / 5 + 32
        return fahrenheit
    }
    //Temperature switch
    
    @IBAction func switchTemp(_ sender: Any) {
        let celsius = currentWeather.currentTemp.rounded(toPlaces: 1)
        let fahrenheit = (celsius * 9 / 5 + 32).rounded(toPlaces: 1)
        if temperatureSwitch.isOn{
            temperature.text = "\(String(celsius))°C"
        } else {
            temperature.text = "\(String(fahrenheit))°F"
        }
    }
}
//Ref: https://developers.google.com/places/ios-sdk/autocomplete#add_a_results_controller
// Handle the user's selection.
extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        //currentLocation = locationManager.location
        print("Place name: \(place.name)")
        print("Place latitude: \((place.coordinate.latitude).rounded(toPlaces: 2))")
        print("Place longitude: \((place.coordinate.longitude).rounded(toPlaces: 2))")
        if let loc = locationManager.location {
            //Pass coordinate to API in Extras.swift
            latitude = ((place.coordinate.latitude).rounded(toPlaces: 2))
            longitude = ((place.coordinate.longitude).rounded(toPlaces: 2))
            print("Lat: ", Location.sharedInstance.latitude)
            print("Lon: ", Location.sharedInstance.longitude)
            //Download API data of that coordinate
            currentWeather.downloadCurrentWeather {
                //Update UI after download successful
                print(self)
                self.updateUI()
            }
        }
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        print("Error: Cannot get the location - ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

