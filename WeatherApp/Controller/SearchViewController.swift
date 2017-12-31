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
        static let citySegueIdentifier = "citySegue"
        
    }

    // MARK: -  stored properties

    var cities = [String]()




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
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: Constants.cityCellIdentifier, for: indexPath)

        cell.textLabel?.text = cities[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = citiesTableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: Constants.citySegueIdentifier, sender: cell)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is WeatherViewController {
            let cell = sender as! UITableViewCell
            let destinationController = segue.destination as! WeatherViewController
            destinationController.navigationItem.title = cell.textLabel?.text
            destinationController.cityName = (cell.textLabel?.text)!
        }
    }


    // MARK: -  custom methods

    private func setUpUI() {
        
    }


    



}
