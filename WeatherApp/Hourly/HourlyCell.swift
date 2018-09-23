//
//  HourlyCell.swift
//  WeatherApp
//
//  Created by Linh Do on 9/23/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import UIKit

class HourlyCell: UITableViewCell {

    @IBOutlet weak var hourlyImgView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func setHourlyWeather(data: HourlyWeather) {
        hourlyImgView.image = UIImage(named: data.icon)
        timeLabel.text = data.time
        tempLabel.text = "\(Int(data.temp))°"
    }
}
