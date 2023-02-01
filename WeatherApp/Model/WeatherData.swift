//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Mehmet Kubilay Akdemir on 1.02.2023.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
}
