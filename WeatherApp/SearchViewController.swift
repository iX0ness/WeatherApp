//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Levchuk Misha on 15.12.2017.
//  Copyright © 2017 Levchuk Misha. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    // MARK: -  Constants

    private struct Constants {
        static let cityCellIdentifier = "cityCell"
        static let test = "test"
    }



    // MARK: -  stored properties

    let cities = Cities()


    // MARK: -  outlets
    @IBOutlet weak var citiesTableView: UITableView!

    // MARK: -  Main method

    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
    }

    // MARK: -  delegate and datasource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.citiesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: Constants.cityCellIdentifier, for: indexPath)
        let sortedCities = cities.citiesArray.sorted()
        cell.textLabel?.text = sortedCities[indexPath.row]

        return cell
    }

    // MARK: -  custom methods

    func setUpUI() {
        
    }
    



}
