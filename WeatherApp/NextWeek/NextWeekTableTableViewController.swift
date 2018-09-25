//
//  NextWeekTableTableViewController.swift
//  WeatherApp
//
//  Created by Bill on 9/25/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import UIKit

class NextWeekTableTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)

        // Configure the cell...

        return cell
    }
}
