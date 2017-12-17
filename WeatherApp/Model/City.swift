//
//  City.swift
//  WeatherApp
//
//  Created by Levchuk Misha on 17.12.2017.
//  Copyright © 2017 Levchuk Misha. All rights reserved.
//

import Foundation

class City {
    var name: String
    var country: String

    init(name: String, country: String) {
        self.name = name
        self.country = country
    }

    func description() -> String {
        return "\(self.name) \(self.country)"
    }
}
