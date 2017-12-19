//
//  Networking.swift
//  WeatherApp
//
//  Created by Levchuk Misha on 15.12.2017.
//  Copyright © 2017 Levchuk Misha. All rights reserved.
//

import Foundation


class Networking {

    var jsonURLString: String
    var url: URL
    var weather = [Weather]()

    init(jsonURLString: String) {
        self.jsonURLString = jsonURLString
        self.url = URL(string: jsonURLString)!
    }

    func getWeatherInfo() {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                self.weather = try JSONDecoder().decode([Weather].self, from: data!)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    func description() {
        for w in weather {
            print("\(w.current.condition) \(w.location.name)")
        }
    }

    

}
