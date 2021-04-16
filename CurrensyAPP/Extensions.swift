//
//  Extensions.swift
//  CurrensyAPP
//
//  Created by Stanislav Frolov on 07.04.2021.
//

import UIKit


extension ViewController: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if apiClient.currensyName.isEmpty == false{
            return apiClient.currensyName.count as Int
        }
        else {
            print("Something wrong with API") ; return 3
        }
    }
}
extension ViewController: UIPickerViewDelegate, UITextFieldDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return apiClient.currensyName[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentCurrensy = pickerView.selectedRow(inComponent: 0)
        let resultCurrensy = pickerView.selectedRow(inComponent: 1)
        
        if let key = apiClient.latestCurrensy.key(from: apiClient.currensyName[resultCurrensy]) {
           self.resultMultiplier = apiClient.latestRates[key] ?? 0.0
           }
        
         if let key = apiClient.latestCurrensy.key(from: apiClient.currensyName[currentCurrensy]) {
            self.baseMultiplier = apiClient.latestRates[key] ?? 0.0
            }
        calculate(userValue: Double(self.textField1.text!) ?? 0.0)
    }
}
    
    // Extension for search in Dictionary
extension Dictionary where Value: Equatable {
    public func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}
