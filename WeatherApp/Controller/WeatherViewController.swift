//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Levchuk Misha on 17.12.2017.
//  Copyright © 2017 Levchuk Misha. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: -  outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!

    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var windSpeedValueLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var feelsLikeValueLabel: UILabel!
    @IBOutlet weak var visibilityValueLabel: UILabel!


    // MARK: -  stored properties
    
    var celsiusDegree: Int!
    var condition: String!
    var imageURL: String!
    var cityName = String()
    var windSpeed: Int!
    var pressure: Int!
    var humidity: Int!
    var feelsLike: Int!
    var visibility: Int!
    var country: String!
    var exists: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()


    }

    func getWeather() {
        let urlRequest = URLRequest(url: URL(string:"http://api.apixu.com/v1/current.json?key=f65419cbcdee49de8c7223718171712&q=\(cityName)")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    if let current = json["current"] as? [String: AnyObject] {
                        if let temperature = current["temp_c"] as? Int {
                            self.celsiusDegree = temperature
                        }

                        if let windSpeed = current["wind_kph"] as? Double {
                            self.windSpeed = Int(windSpeed)
                        }

                        if let pressure = current["pressure_mb"] as? Int {
                            self.pressure = pressure
                        }

                        if let humidity = current["humidity"] as? Int {
                            self.humidity = humidity
                        }

                        if let feelsLike = current["feelslike_c"] as? Double {
                            self.feelsLike = Int(feelsLike)
                        }

                        if let visibility = current["vis_km"] as? Int {
                            self.visibility = visibility
                        }

                        if let condition = current["condition"] as? [String: AnyObject] {
                            self.condition = condition["text"] as! String
                            let icon = condition["icon"] as! String
                            self.imageURL = "http:\(icon)"
                        }
                    }

                    if let location = json["location"] as? [String: AnyObject] {
                        self.cityName = location["name"] as! String
                        self.country = location["country"] as! String
                        
                    }

                    if let _ = json["error"] {
                        self.exists = false
                    }

                    DispatchQueue.main.async {
                        if self.exists {
                            self.cityNameLabel.isHidden = false
                            self.temperatureLabel.isHidden = false
                            self.conditionLabel.isHidden = false
                            self.weatherImageView.isHidden = false
                            self.countryLabel.isHidden = false
                            self.windSpeedLabel.isHidden = false
                            self.pressureLabel.isHidden = false
                            self.feelsLikeLabel.isHidden = false
                            self.visibilityLabel.isHidden = false
                            self.humidityLabel.isHidden = false
                            self.windSpeedValueLabel.isHidden = false
                            self.pressureValueLabel.isHidden = false
                            self.humidityValueLabel.isHidden = false
                            self.feelsLikeValueLabel.isHidden = false
                            self.visibilityValueLabel.isHidden = false
                            self.conditionLabel.text = self.condition
                            self.cityNameLabel.text = self.cityName
                            self.countryLabel.text = self.country
                            self.temperatureLabel.text = "\(self.celsiusDegree.description)°"
                            self.windSpeedValueLabel.text = "\(self.windSpeed.description) km/h"
                            self.pressureValueLabel.text = "\(self.pressure.description) hPa"
                            self.feelsLikeValueLabel.text = "\(self.feelsLike.description)°"
                            self.visibilityValueLabel.text = "\(self.visibility.description) km"
                            self.humidityValueLabel.text = "\(self.humidity.description) %"
                            self.weatherImageView.dowloadImage(from: self.imageURL!)
                        } else {
                            self.temperatureLabel.isHidden = true
                            self.conditionLabel.isHidden = true
                            self.weatherImageView.isHidden = true
                            self.countryLabel.isHidden = true
                            self.windSpeedLabel.isHidden = true
                            self.humidityLabel.isHidden = true
                            self.pressureLabel.isHidden = true
                            self.feelsLikeLabel.isHidden = true
                            self.visibilityLabel.isHidden = true
                            self.windSpeedValueLabel.isHidden = true
                            self.pressureValueLabel.isHidden = true
                            self.feelsLikeValueLabel.isHidden = true
                            self.humidityValueLabel.isHidden = true
                            self.visibilityValueLabel.isHidden = true
                            self.cityNameLabel.text = "No matching city found"
                            self.exists = true
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }

}
