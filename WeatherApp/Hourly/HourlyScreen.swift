//
//  HourlyScreen.swift
//  WeatherApp
//
//  Created by Linh Do on 9/22/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import UIKit
import CoreLocation

class HourlyScreen: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var hourlyData:[HourlyWeather] = []
    
    let api = "https://api.darksky.net/forecast/b9fc9277797647a38161d0f28d058376/"
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if let tbc = self.tabBarController as? CustomTabController {
//            if let location = tbc.location {
//                onLocationUpdate(coordinate: location)
//            }
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tbc = self.tabBarController as? CustomTabController {
            if let location = tbc.location {
                onLocationUpdate(coordinate: location)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HourlyScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = hourlyData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyCell") as! HourlyCell
        cell.setHourlyWeather(data: data)
        return cell
    }
    
    
}















