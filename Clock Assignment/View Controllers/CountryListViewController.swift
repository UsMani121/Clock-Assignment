//
//  CountryListViewController.swift
//  Clock Assignment
//
//  Created by Muhammad Usman on 07/07/2021.
//

import UIKit

protocol CountryListViewControllerDelegate : AnyObject{
    func countryListViewController(_ countryViewController : CountryListViewController ,countryname : String , countryGMT : String)
}

class CountryListViewController: UIViewController {

    var countriesSectionArray = [String]()
    var countriesDictionary = [String : [String]]()
    var countriesArray = [String]()
    
    var empty : [String]?
    var emptuy = ""
        
    var searchArray : [String] = []
    var searching = false
    
    var countryListVCDelegate : CountryListViewControllerDelegate!
    
    var countriesParsedArray:[CountriesJsonDataModelClass] = [] {
        didSet {
            self.countriesArray = countriesParsedArray.map { obj in
                return obj.name
            }
        }
    }
    
    @IBOutlet weak var countryListSearchBar: UISearchBar!
    @IBOutlet weak var countryListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        countryListTableView.delegate = self
        countryListTableView.dataSource = self
        countryListSearchBar.delegate = self
        
        let path = Bundle.main.path(forResource: "Json File", ofType: "json")
        
        let url = URL(fileURLWithPath: path!)
        
        do{
            let data = try Data(contentsOf: url)
            countriesParsedArray = try JSONDecoder().decode([CountriesJsonDataModelClass].self, from: data)
            countriesParsedArray.sort{
                $0.name < $1.name
            }
        
        }catch {
        }
        
        if let cb : UIButton = countryListSearchBar.value(forKey: "cancelButton" ) as? UIButton{
            cb.isEnabled = true
            
        }
        searchArray = countriesArray
        
        generateWordsDict()
        
        
    }
    
    func generateWordsDict(){
        
        
            for countries in countriesArray {
                
                
                let key = String(countries.prefix(1))
                
                
                if var countryValues = countriesDictionary[key]{
                    countryValues.append(countries)
                    countriesDictionary[key] = countryValues
                }
                else {
                    countriesDictionary[key] = [countries]
                }

            }
            countriesSectionArray = [String](countriesDictionary.keys)
            countriesSectionArray = countriesSectionArray.sorted()
        }
   

}

extension CountryListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if searching{
            return searchArray.count
        }
        else{
        let countryKey = countriesSectionArray[section]
            if let countryValue = countriesDictionary[countryKey]{
                return countryValue.count
            }else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = countryListTableView.dequeueReusableCell(withIdentifier: "CountryListCell", for: indexPath)
        
        cell.textLabel?.textColor = .white
        
   
            if searching {
                cell.textLabel?.text = searchArray[indexPath.row]
            }
            else{
                let countryKey = countriesSectionArray[indexPath.section]
                
                if let countryValue = countriesDictionary[countryKey]{
                    
                cell.textLabel?.text = countryValue[indexPath.row]
            }
        }
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
      
        if searching{
            return 0
        }else{
            return countriesSectionArray.count

        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if searching{
            return emptuy
        }else{
            return countriesSectionArray[section]

        }
        
        
                
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data: String = ""
        if searching {
            data = searchArray[indexPath.row]
        } else {
            
            let countryKey = countriesSectionArray[indexPath.section]
            
            if let countryValue = countriesDictionary[countryKey]{
                
            data = countryValue[indexPath.row]
        }
        }
        
    

        if let obj = countriesParsedArray.first(where: { obj in
            
            
            return obj.name == data
        }) {
            
            print(obj.name)
            
            countryListVCDelegate.countryListViewController(self, countryname: obj.name, countryGMT: obj.GMT)
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searching{
            return empty
        }else{
            return countriesSectionArray
        }
        
    }
    
}


extension CountryListViewController : UISearchBarDelegate {
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        searchArray = countriesArray.filter({$0.prefix(searchText.count) == searchText})
        print(searchArray.count)
        searching = true
        countryListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
