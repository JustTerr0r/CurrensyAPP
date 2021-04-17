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
    
    let calcBack = UIImage(named: "calcBack")
    let pickerBack = UIImage(named: "pickerBack")
    let textFieldBack = UIImage(named: "textFieldBack")
    
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
        } else {
            print ("News data is missing")
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = self.news[indexPath.row].url
        tableView.deselectRow(at: indexPath, animated: false)
        if let url = URL(string: link) {
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
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
        cell.backgroundColor = UIColor(red: 141/255, green: 151/255, blue: 170/255, alpha: 0.45)
           return cell
    }

    // Set Constrains
    private func initialize() {
        resultLabel.text = "I'll Get"
        resultLabel.font = UIFont.systemFont(ofSize: 17)
        
        textField1.placeholder = "I Have"
        textField1.font = UIFont.systemFont(ofSize: 17)
        textField1.backgroundColor = UIColor(red: 158/255, green: 167/255, blue: 183/255, alpha: 1)
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
            maker.height.equalToSuperview().multipliedBy(0.35)
            maker.width.equalTo(view.snp.width).multipliedBy(1)
        }
        
        let calcBack = UIImageView(image: self.calcBack)
        view.addSubview(calcBack)
        calcBack.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(1)
            maker.height.equalToSuperview().multipliedBy(1)
          //  maker.bottom.lessThanOrEqualToSuperview()
        }
        
        let pickerBack = UIImageView(image: self.pickerBack)
        calcBack.addSubview(pickerBack)
        pickerBack.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
            maker.height.equalTo(calcBack).multipliedBy(0.3)
            maker.top.equalTo(calcBack).inset(100)
        }
        
        view.addSubview(picker)
        picker.snp.makeConstraints { (maker) in
            maker.edges.equalTo(pickerBack)
        }
        
        let textFieldBack = UIImageView(image: self.textFieldBack)
        calcBack.addSubview(textFieldBack)
        textFieldBack.snp.makeConstraints { (maker) in
            maker.center.width.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.07)
        }
        view.addSubview(textField1)
        textField1.snp.makeConstraints { (maker) in
            maker.top.equalTo(textFieldBack.snp.top).inset(15)
            maker.left.equalTo(textFieldBack.snp.left).inset(20)
            maker.width.equalTo(100).priority(1000)
        }
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(textFieldBack.snp.top).inset(15)
            maker.right.equalTo(textFieldBack.snp.right).inset(20)
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

