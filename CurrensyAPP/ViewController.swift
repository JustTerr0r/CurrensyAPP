//
//  ViewController.swift
//  CurrensyAPP
//
//  Created by Stanislav Frolov on 25.03.2021.
//

import UIKit
import SnapKit
import SDWebImage
import SafariServices


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var apiClient: ApiClient = ApiClient()
    let picker = UIPickerView()
    var textField1 : UITextField = UITextField (frame: CGRect(x: 20, y: 100, width: 300, height: 35))
    var resultLabel = UILabel()
    let tableView = UITableView.init(frame: .zero)  // News tableView
    var news = [News]()
    
    var baseMultiplier: Double = 0.0
    var resultMultiplier: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient.fetchSomeMoney()
        apiClient.fetchNews(lang: "ru")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.initialize(); self.news = self.apiClient.newsData} // Delay for API
        }
    
    // Converter Core
    public func calculate(userValue: Double){
        var userValueInBase: Double = 0.0
        var result: Double = 0.0
        
        userValueInBase = userValue / self.baseMultiplier
        result = userValueInBase * self.resultMultiplier
        
        self.resultLabel.text = String(format: "%.3f", result)
        
        userValueInBase = 0.0
        result = 0.0
        
        }
    
    // News TableView Core
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if apiClient.newsData.isEmpty == false {
            return apiClient.newsData.count
        }
        else {
            print ("News data is missing")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   let link = self.news[indexPath.row].url
        tableView.deselectRow(at: indexPath, animated: false)
        print("yoyoy")
        if let url = URL(string: self.news[indexPath.row].url) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
       //  tableView.deselectRow(at: indexPath, animated: false)
     }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! NewsTableViewCell
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 0.2
        cell.layer.masksToBounds = true
        cell.newsImage.sd_setImage(with: URL(string: self.news[indexPath.row].urlToImage ?? ""))
        cell.titleLabel.text = self.news[indexPath.row].title
        cell.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
           return cell
    }

    // Set Constrains
    private func initialize() {
        resultLabel.text = "I'll Get"
        resultLabel.font = UIFont.systemFont(ofSize: 17)
        
        textField1.placeholder = "I Have"
        textField1.font = UIFont.systemFont(ofSize: 17)
        textField1.backgroundColor = UIColor(red: 140/255, green: 151/255, blue: 170/255, alpha: 1)
        textField1.keyboardType = UIKeyboardType.numberPad
        
        tableView.backgroundColor = UIColor(red: 88/255, green: 88/255, blue: 90/255, alpha: 1)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.picker.dataSource = self
        self.picker.delegate = self
        self.textField1.delegate = self
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        textField1.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(view.snp.bottom)
            maker.top.equalTo(view.snp.bottom).inset(300)
            maker.width.equalTo(view.snp.width).multipliedBy(1)
        }
        
        view.addSubview(picker)
        picker.snp.makeConstraints { (maker) in
            maker.width.equalTo(view.snp.width).multipliedBy(1)
            maker.top.equalTo(view.snp.top).offset(150)
        }
        view.addSubview(textField1)
        textField1.snp.makeConstraints { (maker) in
            maker.top.equalTo(picker.snp.bottom).offset(50).priority(1000)
            maker.left.lessThanOrEqualTo(view.snp.left).inset(40).priority(1000)
            maker.width.equalTo(100).priority(1000)
        }
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { (maker) in
            maker.right.equalTo(view.snp.right).inset(40)
            maker.top.equalTo(picker.snp.bottom).offset(50)
            maker.bottom.lessThanOrEqualTo(view.snp.bottom).inset(430)
        }
        
    // "No-Button" Calculate
        let editingChanged = UIAction { _ in
            self.calculate(userValue: Double(self.textField1.text!) ?? 0.0)
        }
        textField1.addAction(editingChanged, for: .editingChanged)
        
    // Close Keyboard on Tap
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        }
        
    }

