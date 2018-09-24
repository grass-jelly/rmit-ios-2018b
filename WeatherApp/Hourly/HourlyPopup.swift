
//
//  HourlySettingsController.swift
//  WeatherApp
//
//  Created by Linh Do on 9/24/18.
//  Copyright © 2018 Linh Do. All rights reserved.
//

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
