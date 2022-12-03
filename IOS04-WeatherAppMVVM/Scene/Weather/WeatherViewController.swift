//
//  WeatherViewController.swift
//  IOS04-WeatherAppMVVM
//
//  Created by Mehmet Gökhan Özen on 6.10.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let weatherViewModel1 = WeatherViewModel(repository: NetworkManager())
    var weather: Root!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.layer.borderWidth = 2.0
        cityTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func getWeatherClicked(_ sender: Any) {
        weatherViewModel1.getWeather(city: cityTextField.text!) { data in
            self.weather = data
            
            DispatchQueue.main.async {
                self.cityLabel.text = self.cityTextField.text!.capitalized
                self.tempLabel.text = String(self.weather.main.temp)
                self.windSpeedLabel.text = String(self.weather.wind.speed)
                self.countryLabel.text = String(self.weather.sys.country)
            }
        }
    }
    
}

