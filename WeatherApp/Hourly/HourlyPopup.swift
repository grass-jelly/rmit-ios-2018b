/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Author: Linh Do
 ID: 3689251
 Created date: 22/09/2018
 Acknowledgment:
 Popup: https://www.youtube.com/watch?v=NBCped0ZcWE&t=519s
 Pass data to popup: https://www.youtube.com/watch?v=gZHB0nPYIJE&t=653s
 Notification center: https://www.youtube.com/watch?v=2v9iMmS8I84
 */

import UIKit

class HourlyPopup: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentCtrl: UISegmentedControl!
    
    @IBOutlet weak var segmentCtrl2: UISegmentedControl!
    
    @IBOutlet weak var saveBtn: UIButton!
    var tempAsC:Bool!
    var kph:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentCtrl.selectedSegmentIndex = tempAsC ? 0 : 1
        segmentCtrl2.selectedSegmentIndex = kph ? 0 : 1
    }
   
    @IBAction func onSave(_ sender: Any) {
        NotificationCenter.default.post(name: .save, object: self)
        dismiss(animated: true)
    }

}
