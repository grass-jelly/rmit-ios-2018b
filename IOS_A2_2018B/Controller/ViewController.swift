

import UIKit

class ViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var uvLevel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var background: UIImageView!
    //Constants
    
    
    
    //Variables
    var currentWeather: CurrentWeather!
    
    
    
    //Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyEffect()
        currentWeather = CurrentWeather()
        currentWeather.downloadCurrentWeather {
            self.updateUI()
        }
    }
    
    //Function apply Effect
    func applyEffect() {
        specialEffect(view: background, intensity: 45)
        specialEffect(view: weatherImg, intensity: -45)
    }
    
    //Function Effect when tilt
    func specialEffect(view: UIView, intensity: Double) {
        //Set Horizontal Motion
        let horizontalMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotion.minimumRelativeValue = -intensity
        horizontalMotion.maximumRelativeValue = intensity
        //Set Vertical Motion
        let verticalMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotion.minimumRelativeValue = -intensity
        verticalMotion.maximumRelativeValue = intensity
        //Set movement
        let movement = UIMotionEffectGroup()
        movement.motionEffects = [horizontalMotion, verticalMotion]
        view.addMotionEffect(movement)
    }
    
    //Update UI
    func updateUI() {
        cityName.text = currentWeather.cityName
        temperature.text = "\(currentWeather.currentTemp)"
        //weatherType.text = currentWeather.weatherType
        date.text = currentWeather.date
    }
}

