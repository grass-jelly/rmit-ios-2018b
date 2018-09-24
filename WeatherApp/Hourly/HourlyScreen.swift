//
//  HourlyScreen.swift
//  WeatherApp
//
//  Created by Linh Do on 9/22/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import UIKit
import CoreLocation

class HourlyScreen: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    let api = "https://api.darksky.net/forecast/b9fc9277797647a38161d0f28d058376/"
    let locationManager = CLLocationManager()
    var hourlyData:[HourlyWeather] = []
    var tempAsC:Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        NotificationCenter.default.addObserver(forName: .save, object: nil, queue: OperationQueue.main) {
            (notification) in
            let popup = notification.object as! HourlyPopup
            self.tempAsC = popup.segmentCtrl.selectedSegmentIndex == 0 ? true : false
            self.tableView.reloadData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        onLocationUpdate(coordinate: "\(locValue.latitude),\(locValue.longitude)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let locationName = searchBar.text, !locationName.isEmpty {
            CLGeocoder().geocodeAddressString(locationName) { (placemarks, error) in
                if error != nil || placemarks == nil {/**/}
                else {
                    if let loc = placemarks!.first?.location {
                            let coordinate = "\(loc.coordinate.latitude),\(loc.coordinate.longitude)"
                            self.onLocationUpdate(coordinate: coordinate)
                        }
                    }
                }
            }
        }
    
    func onLocationUpdate(coordinate:String) {
        var tmp:[HourlyWeather] = []
        if let urlToServer = URL.init(string: api+coordinate) {
            let task = URLSession.shared.dataTask(with: urlToServer, completionHandler: { (data, response, error)  in
                if error != nil || data == nil {/**/}
                else {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                            if let hourly = json["hourly"] as? [String:Any] {
                                if let data = hourly["data"] as? [[String:Any]] {
                                    for hour in data {
                                        if let hourlyObj = try? HourlyWeather(json: hour) {
                                            tmp.append(hourlyObj)
                                        }
                                    }
                                    self.hourlyData = tmp
                                    DispatchQueue.main.async {self.tableView.reloadData()}
                                }
                            }
                        }
                    } catch {/**/}
                }
            })
            task.resume()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHourlyPopupSegue" {
            let popup = segue.destination as! HourlyPopup
            popup.tempAsC = tempAsC
        }
    }

}

extension HourlyScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = hourlyData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyCell") as! HourlyCell
        cell.setHourlyWeather(data: data, tempAsC: tempAsC)
        return cell
    }
}















