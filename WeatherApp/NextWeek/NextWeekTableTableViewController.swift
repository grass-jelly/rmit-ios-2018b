//
//  NextWeekTableTableViewController.swift
//  WeatherApp
//
//  Created by Bill on 9/25/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//
import UIKit
import Alamofire

class NextWeekTableTableViewController: UITableViewController {
    @IBOutlet var forecastTable: UITableView!
    
    var forecastWeather: NextWeek!
    var weatherArray = [NextWeek]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchWeather {
            print("DATA DOWNLOADED")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! NextWeekTableViewCell
        
        cell.configCell(forecastData: weatherArray[indexPath.row])
        
        return cell
    }
    
    func fetchWeather(completed: @escaping DownloadComplete) {
        Alamofire.request(FORECAST_API_URL).responseJSON { (response) in
            let result = response.result
            if let dictionary = result.value as? Dictionary <String, AnyObject> {
                if let list = dictionary["list"] as? [Dictionary <String, AnyObject>] {
                    for item in list {
                        let forecast = NextWeek(weatherDictionary: item)
                        self.weatherArray.append(forecast)
                    }
                    self.weatherArray.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
}

