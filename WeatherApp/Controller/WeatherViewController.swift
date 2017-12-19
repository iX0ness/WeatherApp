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
    

    // MARK: -  stored properties
    var cityName = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("City name:\(cityName)")

        
    }



}
