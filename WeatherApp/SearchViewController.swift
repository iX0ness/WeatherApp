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
        
    }

    // MARK: -  stored properties

    let cities = Cities()
    var searchController: UISearchController!
    var isSearching = false
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


    // MARK: -  custom methods

    private func setUpUI() {
        
    }


    



}
