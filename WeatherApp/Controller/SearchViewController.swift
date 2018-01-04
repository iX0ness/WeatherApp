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

    var cities = [City]()
    let backgroundImage = UIImageView(image: UIImage(named: "Bar"))



    // MARK: -  outlets
    @IBOutlet weak var citiesTableView: UITableView!

    

    // MARK: -  Main method

    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let index = self.citiesTableView.indexPathForSelectedRow{
            self.citiesTableView.deselectRow(at: index, animated: false)
        }
    }

    // MARK: -  delegate and datasource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: Constants.cityCellIdentifier, for: indexPath)

        cell.textLabel?.text = cities[indexPath.row].name
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = citiesTableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: Constants.citySegueIdentifier, sender: cell)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        cities.remove(at: indexPath.row)

        citiesTableView.deleteRows(at: [indexPath], with: .automatic)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is WeatherViewController {
            let cell = sender as! UITableViewCell
            let destinationController = segue.destination as! WeatherViewController
            destinationController.navigationItem.title = cell.textLabel?.text
            destinationController.cityName = (cell.textLabel?.text)!
        }
    }

    func add(_ city: City) {
        let index = 0
        cities.insert(city, at: index)

        let indexPath = IndexPath(row: index, section: 0)
        citiesTableView.insertRows(at: [indexPath], with: .left)
    }

    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addTextField { (cityTextField) in
            cityTextField.placeholder = "Enter City Name"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            if let cityName = alert.textFields?.first?.text {
                let city = City(name: cityName)
                self.add(city)
            }

        }
        alert.addAction(action)
        present(alert, animated: true)
    }

    // MARK: -  custom methods

    private func setUpUI() {
        backgroundImage.contentMode = .scaleAspectFill
        citiesTableView.backgroundView = backgroundImage
    }

}
