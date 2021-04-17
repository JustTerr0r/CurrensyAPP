//
//  ApiClient.swift
//  CurrensyAPP
//
//  Created by Stanislav Frolov on 25.03.2021.

import Foundation
import SwiftyJSON
import Alamofire

class ApiClient {
    
    let apiKey = "24e362b5db1f48cf927ab5f75aa993bc"
    let newsApiKey = "8ed53fee783f4e63ab73dda1226e01ce"
    var newsData: [News] = []
    var date: String = ""
    
    let newsLang = ["us","ru","jp"]
    var rates: [String: Any] = [:]  // From JSON
    var currensy: [String: Any] = [:] // From JSON
    var currensyName = [String]() // Picker's Title's
    var latestCurrensy: [String: String] = [:] // Final
    var latestRates: [String: Double] = [:] // Final

    // Fetch Title's
    func fetchCurrensy() {
        let request = AF.request("https://openexchangerates.org/api/currencies.json")
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                
                DispatchQueue.main.async {
                    let json = JSON(value)
                    var names = [String]()
                    self.currensy = json.dictionaryObject ?? [:]
                    
                    names.append(contentsOf: self.currensy.keys)
                    for i in names {
                        if (self.currensy[i] is String) {
                            self.currensyName.append(self.currensy[i] as? String ?? "nil")
                        }
                    }
                    self.latestCurrensy = Dictionary(uniqueKeysWithValues: zip(names, self.currensyName))
                    self.currensyName = self.currensyName.sorted()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Fetch Rates
    func fetchRates() {
        let request = AF.request("https://openexchangerates.org/api/latest.json?app_id=\(apiKey)&base=USD")
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                
                DispatchQueue.main.async {
                    var names = [String]()
                    var rate = [Double]()
                    let json = JSON(value)
                    self.rates = json["rates"].dictionaryObject ?? [:]
                    
                    names.append(contentsOf: self.rates.keys)
                    for i in names {
                        if (self.rates[i] is Double) {
                            rate.append(self.rates[i] as? Double ?? 0.0)
                        }
                    }
                    self.latestRates = Dictionary(uniqueKeysWithValues: zip(names, rate))
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Fetch News
    func fetchNews(lang: String){

        let request = AF.request("https://newsapi.org/v2/top-headlines?country=\(lang)&category=business&apiKey=\(newsApiKey)")

        request.responseJSON { response in
            switch response.result {
                   case .success(let value):
                       let json = JSON(value)
                       var models = [News]()
                       for item in json["articles"].arrayValue {
                           let model = News(title: item["title"].stringValue,
                                            description: item["description"].stringValue,
                                            url: item["url"].stringValue,
                                            urlToImage: item["urlToImage"].stringValue)
                           models.append(model)
                       }
                    self.newsData = models
                    print("source is" + self.newsData[0].url)
                   case .failure(let error):
                       print(error)
                   }
        }
    }
    
    func fetchSomeMoney() {
        self.fetchRates()
        self.fetchCurrensy()
    }
}

