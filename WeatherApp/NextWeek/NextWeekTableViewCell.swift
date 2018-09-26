//
//  NextWeekTableViewCell.swift
//  WeatherApp
//
//  Created by Bill on 9/26/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

import UIKit

class NextWeekTableViewCell: UITableViewCell {
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var forecastTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(forecastData: NextWeek) {
        self.forecastDate.text = "\(forecastData.date)"
        self.forecastTemp.text = "\(Int(forecastData.minTemp))° - \(Int(forecastData.maxTemp))°"
    }

}
