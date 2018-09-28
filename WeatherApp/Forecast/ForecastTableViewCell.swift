/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Do Huy Hoang
 ID: s3446390
 Created date: 24/09/2018
 Acknowledgment:
 */

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    func configCell(data: Weather) {
        icon.image = UIImage(named: data.icon)
        summary.text = data.summary
        temp.text = "\(Int(round((data.temp - 32) / 1.8)))°C"
    }
}
