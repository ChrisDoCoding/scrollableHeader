//
//  HeaderItemCell.swift
//  ScrollableHeader
//
//  Created by Chris Chen on 2020/5/9.
//  Copyright © 2020 Dev4App. All rights reserved.
//

import UIKit

class HeaderItemCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addSubviewConstraints()
        initCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        
        label.font = DefaultFont
        label.textAlignment = .center
        label.textColor = .black
        
        addSubview(label)
    }

    func addSubviewConstraints() {
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
    }

    func initCell() {
        label.text = ""
    }

    func configureCell() {
        
    }
}
