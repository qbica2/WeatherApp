//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mehmet Kubilay Akdemir on 1.02.2023.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var feelslikeStackView: UIStackView!
    @IBOutlet weak var windStackView: UIStackView!
    @IBOutlet weak var humidityStackView: UIStackView!
    @IBOutlet weak var pressureStackView: UIStackView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for x in [topStackView, feelslikeStackView, windStackView, humidityStackView, pressureStackView] {
            x?.layer.cornerRadius = 12
            x?.layer.masksToBounds = true
        }
    }


}

