/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Do Huy Hoang
 ID: s3446390
 Created date: 24/09/2018
 Acknowledgment:
 URLSession: https://www.lynda.com/iOS-tutorials/Manage-text-JSON-from-server/645028/682880-4.html
 */

import UIKit
import CoreLocation

class ForecastTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var forecastData = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        fetchWeather(location: "Ho Chi Minh")
    }
    
    //Searchbar function
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            fetchWeather(location: locationString)
        }
    }
    
    //Update weather based on location
    func fetchWeather (location: String) {
        CLGeocoder().geocodeAddressString(location) { (placemark:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemark?.first?.location {
                    Weather.forecast(withLocation: location.coordinate, completion: { (result:[Weather]?) in
                        if let weatherData = result {
                            self.forecastData = weatherData
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }



    override func numberOfSections(in tableView: UITableView) -> Int {

        return forecastData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    //Add header contains month, date, and year
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        return dateFormatter.string(from: date!)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as! ForecastTableViewCell

        let weatherObject = forecastData[indexPath.section]
        cell.configCell(data: weatherObject)
        
        return cell
    }
}
