//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Levchuk Misha on 15.12.2017.
//  Copyright © 2017 Levchuk Misha. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {


    // MARK: -  Constants

    private struct Constants {
        static let cityCellIdentifier = "cityCell"
        static let citySegueIdentifier = "citySegue"
        
    }

    // MARK: -  stored properties

    let cities = Cities()
    var filteredCities = [String]()



    // MARK: -  outlets
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    // MARK: -  Main method

    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        searchBar.delegate = self

        filteredCities = cities.citiesArray
    }

    // MARK: -  delegate and datasource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: Constants.cityCellIdentifier, for: indexPath)
        let sortedCities = filteredCities.sorted()
        cell.textLabel?.text = sortedCities[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = citiesTableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: Constants.citySegueIdentifier, sender: cell)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText .isEmpty else {
            filteredCities = cities.citiesArray
            citiesTableView.reloadData()
            return
        }

        filteredCities = cities.citiesArray.filter({ (word) -> Bool in
            guard searchBar.text != nil else {return false}
            return word.lowercased().contains(searchText.lowercased())
        })
        citiesTableView.reloadData()
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
