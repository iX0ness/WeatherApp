//
//  Weather.swift
//  WeatherApp
//
//  Created by Levchuk Misha on 18.12.2017.
//  Copyright © 2017 Levchuk Misha. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    var location: Location
    var current: Current
}

struct Location: Decodable {
    var name: String
}

struct Current: Decodable {
    var condition: Condition
}

struct Condition: Decodable {
    var text: String
    var image: String
}
