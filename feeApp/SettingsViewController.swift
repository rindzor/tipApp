//
//  SettingsViewController.swift
//  feeApp
//
//  Created by  mac on 3/12/20.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func changeTips(first: String, second: String, third: String)
}

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var percentSegment: UISegmentedControl!
    @IBOutlet weak var percentPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var first: String?
    var second: String?
    var third: String?
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        percentSegment.setTitle(first, forSegmentAt: 0)
        percentSegment.setTitle(second, forSegmentAt: 1)
        percentSegment.setTitle(third, forSegmentAt: 2)
        
        for i in 1...100 {
            pickerData.append("\(i)%")
        }
        
        updateUIWhenChangeSegment()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.percentPicker.delegate = self
        self.percentPicker.dataSource = self
        
    }
    

    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.changeTips(first: percentSegment.titleForSegment(at: 0)!, second: percentSegment.titleForSegment(at: 1)!, third: percentSegment.titleForSegment(at: 2)!)
    }
    
    @IBAction func showCountriesListPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCountries", sender: self)
    }
    
    
    func updateUIWhenChangeSegment() {
        let row = Int(percentSegment.titleForSegment(at: percentSegment.selectedSegmentIndex)?.dropLast() ?? "1") ?? 1
        percentPicker.selectRow(row-1, inComponent: 0, animated: true)
    }
    
    @IBAction func percentSegmentPressed(_ sender: Any) {
        updateUIWhenChangeSegment()
    }
    
    
    
    //
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerData[row])
        percentSegment.setTitle(pickerData[row], forSegmentAt: percentSegment.selectedSegmentIndex)
    }
    
    // Переход между segue VC с Navigation Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCountries" {

            let navigationContoller = segue.destination as! UINavigationController

            let receiverViewController = navigationContoller.topViewController as? CountriesTableViewController
            receiverViewController?.delegate = self
        }
    }
}

extension SettingsViewController: CountriesTableViewControllerDelegate {
    func sendCountryData(tip: String) {
//        print("!!!!")
//        print(tip)
        let leftSegmentTip = Int(tip.dropLast()) ?? 1
        let rightSegmentTip = Int(tip.dropLast()) ?? 1
        self.percentSegment.setTitle("\(leftSegmentTip-1)%", forSegmentAt: 0)
        self.percentSegment.setTitle(tip, forSegmentAt: 1)
        self.percentSegment.setTitle("\(rightSegmentTip+1)%", forSegmentAt: 2)
        self.percentSegment.selectedSegmentIndex = 1
        updateUIWhenChangeSegment()
    }
}

