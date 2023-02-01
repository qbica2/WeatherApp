//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mehmet Kubilay Akdemir on 1.02.2023.
//

import Foundation
import CoreLocation

struct WeatherManager {
    
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=3917a538a36ae4dca6aaa7d20eae9a31&units=metric"
    
    func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees){
        let urlString = "\(baseURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print("error")
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        print(weather)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data ) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            print("error")
            return nil
        }
        
        
    }
    
    
    
}
