//
//  WeatherManager_.swift
//  Clima
//
//  Created by sei_dev on 11/14/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

// swift convention에 따르면, protocol을 사용하는 곳에 protocol을 정의한다.
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    //http로 하면 보안 문제로 warning message 뜸
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e02252231bdc95dc8132c15da394929d&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create a URL
        guard let url = URL(string: urlString) else {
            return
        }
        // 2. Create a URLSession
        let session = URLSession(configuration: .default)
        
        // 3. Give the session a task
        // closure 안에서는 self가 필요했는데, 지금은 괜찮은거야?
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data {
                if let weather = parseJSON(safeData) {
                    delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        // 4. Start the task
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        // parsing 하려면 데이터 structure를 우선 정의해야함.
        let decoder = JSONDecoder()
        // (type : 그자체 ".self", data)
        // decode는 can throw이기에, error를 처리하지 않으면 오류를 뱉음
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperature)
            print(weather.temperatureString)
            
            return weather
            
        } catch {
            // decode가 실패했을 때
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
