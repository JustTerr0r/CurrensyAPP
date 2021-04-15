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
 
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIImage{
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: 50
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
