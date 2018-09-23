//
//  SettingsScreen.swift
//  WeatherApp
//
//  Created by Linh Do on 9/23/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import UIKit
import CoreLocation

class SettingsScreen: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let locationName = searchBar.text, !locationName.isEmpty {
            CLGeocoder().geocodeAddressString(locationName) { (placemarks, error) in
                if error != nil || placemarks == nil {/**/}
                else {
                    if let loc = placemarks!.first?.location {
                        if let tbc = self.tabBarController as? CustomTabController {
                             tbc.location = "\(loc.coordinate.latitude),\(loc.coordinate.longitude)"
                        }
                        
                    }
                }
            }
        }
    }
    
}
