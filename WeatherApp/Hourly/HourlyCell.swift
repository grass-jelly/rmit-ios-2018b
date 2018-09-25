/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Linh Do
 ID: 3689251
 Created date: 22/09/2018
 Acknowledgment:
 Custom Cell: https://www.youtube.com/watch?v=FtO5QT2D_H8&t=744s
 */

import UIKit

class HourlyCell: UITableViewCell {

    @IBOutlet weak var hourlyImgView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func setHourlyWeather(data: HourlyWeather, showing: String, tempAsC: Bool, kph: Bool) {
        hourlyImgView.image = UIImage(named: data.icon)
        timeLabel.text = data.time
        
        switch showing {
        case "temp":
            if tempAsC { tempLabel.text = "\(Int(round( (data.temp - 32) / 1.8 )))°C" }
            else { tempLabel.text = "\(Int(round(data.temp)))°F" }
        case "wind":
            if kph { tempLabel.text = "\(Int(round(data.wind))) kph" }
            else { tempLabel.text = "\(Int(round(data.wind * 0.6214))) mph" }
        case "humidity":
            tempLabel.text = "\(Int(data.humidity * 100))%"
        case "uv":
            tempLabel.text = "\(data.uv)"
        default:
            break
        }
        
    }
}
