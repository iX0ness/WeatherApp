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

    init(jsonURLString: String) {
        self.jsonURLString = jsonURLString
        self.url = URL(string: jsonURLString)!
    }

    func getWeatherInfo() {
        URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
        }
    }

    

}
