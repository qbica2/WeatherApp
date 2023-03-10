//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mehmet Kubilay Akdemir on 1.02.2023.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var feelslikeStackView: UIStackView!
    @IBOutlet weak var windStackView: UIStackView!
    @IBOutlet weak var humidityStackView: UIStackView!
    @IBOutlet weak var pressureStackView: UIStackView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var feelslikeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var cityName = ""
    
    var coreDataManager = CoreDataManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for x in [topStackView, feelslikeStackView, windStackView, humidityStackView, pressureStackView] {
            x?.layer.cornerRadius = 12
            x?.layer.masksToBounds = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        locationManager.delegate = self
        weatherManager.delegate = self

        
        if cityName == "current" {
            locationManager.requestLocation()
        } else {
            weatherManager.fetchWeather(cityName: cityName)
        }

    }

    @IBAction func savePressed(_ sender: UIButton) {
        coreDataManager.saveData(cityName: cityLabel.text!, id: UUID(), entityName: "Cities")
    }
    
}

//MARK: - WeatherManagerDelegate

extension DetailViewController: WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text = "\(weather.temperatureString)??"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.descriptionLabel.text = weather.description
            self.cityLabel.text = weather.cityName
            self.humidityLabel.text = "% \(weather.humidityString)"
            self.feelslikeLabel.text = "\(weather.feelslikeString)??"
            self.windLabel.text = "\(weather.windSpeedString) km/h"
            self.pressureLabel.text = "\(weather.pressureString) hPa"
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension DetailViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitute: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
}
