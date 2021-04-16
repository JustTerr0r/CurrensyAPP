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

    let titleLabel : UILabel = {
        let lbl = UILabel ()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = false
        return lbl
    }()
    
    let newsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let box: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(box)
        box.addSubview(newsImage)
        
        box.snp.makeConstraints { (maker) in
            maker.size.equalToSuperview().multipliedBy(0.55)
            maker.right.equalToSuperview().inset(-50)
            maker.top.bottom.equalToSuperview().inset(20)
        }
        newsImage.snp.makeConstraints { (maker) in
            maker.size.equalTo(box)
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

