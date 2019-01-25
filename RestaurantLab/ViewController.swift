//
//  ViewController.swift
//  RestaurantLab
//
//  Created by Katherine Mei on 1/25/19.
//  Copyright © 2019 Katherine Mei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    var cities = [String]()
    var restaurants: [String: [String]] = [:]
    var selectedCity = ""
    var selectedRestaurant = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRestaurantData()
    }
    
    //MARK: Picker Data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return cities.count
        } else {
            return restaurants[selectedCity]!.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return cities[row]
        } else {
            return restaurants[selectedCity]![row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            selectedCity = cities[row]
            selectedRestaurant = restaurants[selectedCity]![0]
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
        } else {
            selectedRestaurant = restaurants[selectedCity]![row]
        }
        updateLabel()
    }
    
    //MARK: Private Methods
    private func getRestaurantData() {
        if let url = Bundle.main.url(forResource: "Restaurants", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let tempDict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String: [String]]
                
                cities = Array(tempDict.keys).sorted()
                for city in cities {
                    restaurants[city] = Array(tempDict[city]!).sorted()
                }
                selectedCity = cities[0]
                selectedRestaurant = restaurants[selectedCity]![0]
                updateLabel()
            } catch {
                print(error)
            }
        }
    }
    
    private func updateLabel() {
        label.text = "\(selectedCity) – \(selectedRestaurant)"
    }
}
