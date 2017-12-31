//
//  CurrentCityWeatherViewController.swift
//  WeatherApp
//
//  Created by Levchuk Misha on 18.12.2017.
//  Copyright © 2017 Levchuk Misha. All rights reserved.
//

import UIKit

class CurrentCityWeatherViewController: UIViewController, UISearchBarDelegate {

    // MARK: -  outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!

    // MARK: -  stored properties
    var celsiusDegree: Int!
    var condition: String!
    var imageURL: String!
    var cityName: String!
    var exists: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let urlRequest = URLRequest(url: URL(string: "http://api.apixu.com/v1/current.json?key=f65419cbcdee49de8c7223718171712&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))")!)

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    if let current = json["current"] as? [String: AnyObject] {
                        if let temperature = current["temp_c"] as? Int {
                            self.celsiusDegree = temperature
                        }

                        if let condition = current["condition"] as? [String: AnyObject] {
                            self.condition = condition["text"] as! String
                            let icon = condition["icon"] as! String
                            self.imageURL = "http:\(icon)"
                        }
                    }

                    if let location = json["location"] as? [String: AnyObject] {
                        self.cityName = location["name"] as! String
                    }

                    if let _ = json["error"] {
                        self.exists = false
                    }

                    DispatchQueue.main.async {
                        if self.exists {
                            self.temperatureLabel.isHidden = false
                            self.conditionLabel.isHidden = false
                            self.weatherImageView.isHidden = false
                            self.temperatureLabel.text = "\(self.celsiusDegree.description)°"
                            self.conditionLabel.text = self.condition
                            self.cityNameLabel.text = self.cityName
                            self.weatherImageView.dowloadImage(from: self.imageURL!)
                        } else {
                            self.temperatureLabel.isHidden = true
                            self.conditionLabel.isHidden = true
                            self.weatherImageView.isHidden = true
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

extension UIImageView {
    func dowloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }
        task.resume()
    }
}
