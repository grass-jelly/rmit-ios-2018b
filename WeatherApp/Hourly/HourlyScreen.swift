/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Linh Do
 ID: 3689251
 Created date: 22/09/2018
 Acknowledgment:
 gets current location: https://stackoverflow.com/questions/25296691/get-users-current-location-coordinates
 URLSession: https://www.lynda.com/iOS-tutorials/Manage-text-JSON-from-server/645028/682880-4.html
 SegmentedControl: https://www.ioscreator.com/tutorials/segmented-control-tutorial-ios10
 MapKit: https://www.youtube.com/watch?v=GYzNsVFyDrU
 Timezone: https://stackoverflow.com/questions/47212198/getting-time-in-swift-4
 */

import UIKit
import CoreLocation
import MapKit

class HourlyScreen: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    let api = "https://api.darksky.net/forecast/b9fc9277797647a38161d0f28d058376/"
    let locationManager = CLLocationManager()
    
    var hourlyData:[HourlyWeather] = []
    
    // display cells according to settings popup
    var tempAsC:Bool = true
    var kph:Bool = true
    
    // display cells according to segmented control 
    var showing:String = "temp"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        NotificationCenter.default.addObserver(forName: .save, object: nil, queue: OperationQueue.main) {
            (notification) in
            let popup = notification.object as! HourlyPopup
            self.tempAsC = popup.segmentCtrl.selectedSegmentIndex == 0 ? true : false
            self.kph = popup.segmentCtrl2.selectedSegmentIndex == 0 ? true : false
            self.tableView.reloadData()
        }
    }
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedCtrl.selectedSegmentIndex {
        case 0:
            showing = "temp"
        case 1:
            showing = "humidity"
        case 2:
            showing = "wind"
        case 3:
            showing = "uv"
        default:
            break
        }
        tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        mapView.showsUserLocation = true
        centerView(center: coordinate)
        onLocationUpdate(coordinate: coordinate)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationName = searchBar.text, !locationName.isEmpty {
            
            // make search request (search bar text)
            let searchRequest = MKLocalSearchRequest()
            searchRequest.naturalLanguageQuery = locationName
            let activeSearch = MKLocalSearch(request: searchRequest)
            
            // handle search response (coordinate)
            activeSearch.start(completionHandler: { (res, err) in
                if (res == nil) {return}
                else {
                    let coordinate = res?.boundingRegion.center
                    
                    // remove annotations
                    let annotations = self.mapView.annotations
                    self.mapView.removeAnnotations(annotations)
                    
                    // add annotation
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate!
                    self.mapView.addAnnotation(annotation)
                    
                    // center map
                    self.centerView(center: coordinate!)
                    
                    // update tableview
                    self.onLocationUpdate(coordinate: coordinate!)
                }
            })
        }
    }
    
    func centerView(center:CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMakeWithDistance(center, 10000, 10000)
        mapView.setRegion(region, animated: true)
    }
    
    func onLocationUpdate(coordinate:CLLocationCoordinate2D) {
        var tmp:[HourlyWeather] = []
        
        let coordinateString = "\(coordinate.latitude),\(coordinate.longitude)"
        
        if let urlToServer = URL.init(string: api+coordinateString) {
            let task = URLSession.shared.dataTask(with: urlToServer, completionHandler: { (data, response, error)  in
                if error != nil || data == nil { return }
                else {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                            if let timezone = json["timezone"] as? String {
                                if let hourly = json["hourly"] as? [String:Any] {
                                    if let data = hourly["data"] as? [[String:Any]] {
                                        for hour in data {
                                            if let hourlyObj = try? HourlyWeather(json: hour, timezone:timezone) {
                                                tmp.append(hourlyObj)
                                            }
                                        }
                                        self.hourlyData = tmp
                                        DispatchQueue.main.async {self.tableView.reloadData()}
                                    }
                                }
                            }
                            
                        }
                    } catch { return }
                }
            })
            task.resume()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHourlyPopupSegue" {
            let popup = segue.destination as! HourlyPopup
            popup.tempAsC = tempAsC
            popup.kph = kph
            
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
        cell.setHourlyWeather(data: data, showing: showing, tempAsC: tempAsC, kph: kph)
        return cell
    }
}















