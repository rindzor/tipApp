//
//  ViewController.swift
//  feeApp
//
//  Created by  mac on 3/11/20.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
 
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var percentSegment: UISegmentedControl!
    
    @IBAction func segmentChanged(_ sender: Any) {
        tipLabel.text = percentSegment.titleForSegment(at: percentSegment.selectedSegmentIndex)
        updateTotalSum()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @objc func textFieldDidChange() {
        updateTotalSum()
    }

    func updateTotalSum() {
        if billTextField.text?.count ?? 0 <= 13 {
            let a = Int(billTextField.text ?? "0") ?? 0
            let b = Int(tipLabel.text?.dropLast() ?? "0") ?? 0
            let c = b * a / 100
            let total = "\(a + c)$"
            totalLabel.text = total
        }
    }
    
    func updateUI() {
        tipLabel.text = percentSegment.titleForSegment(at: percentSegment.selectedSegmentIndex)
        billTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard)))
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func customizePressed(_ sender: UIButton) {
        // can be removed its written in prepare method below
//        let settingsManager = SettingsViewController()
//        settingsManager.delegate = self
        self.performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSettings" {
            if let destinationVC = segue.destination as? SettingsViewController {
                destinationVC.delegate = self
                destinationVC.first = percentSegment.titleForSegment(at: 0)
                destinationVC.second = percentSegment.titleForSegment(at: 1)
                destinationVC.third = percentSegment.titleForSegment(at: 2)
            }
        }
    }
}

extension ViewController: SettingsViewControllerDelegate {
    func changeTips(first: String, second: String, third: String) {
        self.dismiss(animated: true)
        percentSegment.setTitle(first, forSegmentAt: 0)
        percentSegment.setTitle(second, forSegmentAt: 1)
        percentSegment.setTitle(third, forSegmentAt: 2)
        updateUI()
        updateTotalSum()
    }
    
    
}

