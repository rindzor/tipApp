//
//  CountriesTableViewController.swift
//  feeApp
//
//  Created by  mac on 3/15/20.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

protocol CountriesTableViewControllerDelegate {
    func sendCountryData(tip: String)
}

struct Country {
    let flag: String
    let countryName: String
    let tip: String
    let tipInt: Int
}

class CountriesTableViewController: UITableViewController {
    
    let flag: [String] = ["france-512", "italy-512", "egypt-512", "usa-512", "ukr-512", "rus-512", "kz-512", "germany-512", "belarus-512", "canada-512", "est-512", "mnt-512", "moldova-512", "uk-512"]
    let countries: [String] = ["France", "Italy", "Egypt", "USA", "Ukraine", "Russia", "Kazachstan", "Germany", "Belarus", "Canada", "Estonia", "Montenegro", "Moldova", "United Kingdom"]
    let tips: [String] = ["12%", "11%", "9%", "14%", "8%", "9%", "5%", "10%", "8%", "12%", "11%", "5%", "5%", "12%"]
    
    var allCountries: [Country] = []
    
    var filteredCountries: [Country] = []
//    var filteredFlags: [String] = []
//    var filteredTips: [String] = []
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    var delegate: CountriesTableViewControllerDelegate?
    
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        allCountries.append(Country(flag: "france-512", countryName: "France", tip: "12%", tipInt: 12))
        allCountries.append(Country(flag: "italy-512", countryName: "Italy", tip: "11%", tipInt: 11))
        allCountries.append(Country(flag: "egypt-512", countryName: "Egypt", tip: "9%", tipInt: 9))
        allCountries.append(Country(flag: "usa-512", countryName: "USA", tip: "14%", tipInt: 14))
        allCountries.append(Country(flag: "ukr-512", countryName: "Ukraine", tip: "8%", tipInt: 8))
        allCountries.append(Country(flag: "rus-512", countryName: "Russia", tip: "9%", tipInt: 9))
        allCountries.append(Country(flag: "kz-512", countryName: "Kazachstan", tip: "5%", tipInt: 5))
        allCountries.append(Country(flag: "germany-512", countryName: "Germany", tip: "10%", tipInt: 10))
        allCountries.append(Country(flag: "belarus-512", countryName: "Belarus", tip: "8%", tipInt: 8))
        allCountries.append(Country(flag: "canada-512", countryName: "Canada", tip: "12%", tipInt: 12))
        allCountries.append(Country(flag: "est-512", countryName: "Estonia", tip: "11%", tipInt: 11))
        allCountries.append(Country(flag: "mnt-512", countryName: "Montenegro", tip: "5%", tipInt: 5))
        allCountries.append(Country(flag: "moldova-512", countryName: "Moldova", tip: "5%", tipInt: 5))
        allCountries.append(Country(flag: "uk-512", countryName: "United Kingdom", tip: "12%", tipInt: 12))
        super.viewDidLoad()
        setupSearchBarController()
        
    }
    
    func setupSearchBarController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type a country..."
        searchController.searchBar.barTintColor = UIColor.white
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountries.count
        }
        return allCountries.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell

        let country: Country

        if isFiltering {
            country = filteredCountries[indexPath.row]

        } else {
            country = allCountries[indexPath.row]
//            flag = filteredFlags[indexPath.row]
        }
        cell.flag.image = UIImage(named: "\(country.flag)")
        cell.countryName.text = country.countryName
        cell.countryTip.text = country.tip

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country: Country
        if isFiltering {
            country = filteredCountries[indexPath.row]
        } else {
            country = allCountries[indexPath.row]
        }
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        delegate?.sendCountryData(tip: country.tip)
        print(country.tip)
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredCountries = allCountries.filter { (country: Country) -> Bool in
        return country.countryName.lowercased().contains(searchText.lowercased())
      }
      tableView.reloadData()
    }
    
    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "Sort by:", preferredStyle: UIAlertController.Style.actionSheet)
        let sortByCountryName = UIAlertAction(title: "Country name", style: UIAlertAction.Style.default) {(_) in
            self.allCountries = self.allCountries.sorted(by: {$0.countryName < $1.countryName})
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let sortByHighestTip = UIAlertAction(title: "Highest tip", style: UIAlertAction.Style.default)
            {(_) in
                
                self.allCountries = self.allCountries.sorted(by: { $0.tipInt > $1.tipInt })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let sortByLowestTip = UIAlertAction(title: "Lowest tip", style: UIAlertAction.Style.default)
        {(_) in
                
            self.allCountries = self.allCountries.sorted(by: { $0.tipInt < $1.tipInt })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil )
        
        alert.addAction(sortByCountryName)
        alert.addAction(sortByLowestTip)
        alert.addAction(sortByHighestTip)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}

extension CountriesTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
