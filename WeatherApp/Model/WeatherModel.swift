//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Mehmet Kubilay Akdemir on 1.02.2023.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var feelslikeString: String {
        return String(format: "%.1f", feels_like)
    }
    
    var pressureString: String {
        return String(pressure)
    }
    
    var humidityString: String {
        return String(humidity)
    }
    
    var windSpeedString: String {
        return String(format: "%.2f", windSpeed)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
