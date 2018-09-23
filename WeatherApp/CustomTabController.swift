//
//  CustomTabController.swift
//  WeatherApp
//
//  Created by Linh Do on 9/23/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import UIKit
import CoreLocation

class CustomTabController: UITabBarController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()

    var location:String? // coordinate
    
    override func viewDidLoad() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location = "\(locValue.latitude),\(locValue.longitude)"
    }
}
