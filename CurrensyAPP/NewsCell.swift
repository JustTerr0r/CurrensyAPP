//
//  NewsCell.swift
//  CurrensyAPP
//
//  Created by Stanislav Frolov on 12.04.2021.
//

import Foundation
import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
   // var news : News
    static let indentifier = "TableViewCell"
    
    let titleLabel : UILabel = {
        let lbl = UILabel ()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = false
        return lbl
    } ()
    
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let newsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(newsImage)
        
        newsImage.snp.makeConstraints { (maker) in
            maker.width.height.equalToSuperview().multipliedBy(0.6)
            maker.top.bottom.equalToSuperview().inset(20)
            maker.right.equalToSuperview().offset(70)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().inset(10)
            maker.width.equalToSuperview().multipliedBy(0.7)
            maker.height.equalToSuperview()
            maker.top.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
}

