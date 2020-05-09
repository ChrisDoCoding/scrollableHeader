//
//  ContentView.swift
//  ScrollableHeader
//
//  Created by Chris Chen on 2020/5/9.
//  Copyright © 2020 Dev4App. All rights reserved.
//

import UIKit

class ContentView: UIView {
    
    let headerView = HeaderView()
    let scrollView = UIScrollView()
    let view_1 = UIView()
    let view_2 = UIView()
    let view_3 = UIView()
    let view_4 = UIView()
    let view_5 = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubviews()
        addSubviewConstraints()
        initView()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let screenSize = UIScreen.main.bounds.size
        let contentSize = CGSize(width: screenSize.width * 5, height: screenSize.height - 40)
        scrollView.contentSize = contentSize
        
        view_1.backgroundColor = .systemRed
        view_2.backgroundColor = .systemPurple
        view_3.backgroundColor = .systemPink
        view_4.backgroundColor = .systemBlue
        view_5.backgroundColor = .systemGreen
        
        addSubview(headerView)
        scrollView.addSubview(view_1)
        scrollView.addSubview(view_2)
        scrollView.addSubview(view_3)
        scrollView.addSubview(view_4)
        scrollView.addSubview(view_5)
        addSubview(scrollView)
    }
    
    func addSubviewConstraints() {
        
        let screenSize = UIScreen.main.bounds.size
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.height.equalTo(40)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
        }
        
        view_1.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(scrollView.snp.leading)
            make.width.equalTo(screenSize.width)
        }
        
        view_2.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(view_1.snp.trailing)
            make.width.equalTo(screenSize.width)
        }
        
        view_3.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(view_2.snp.trailing)
            make.width.equalTo(screenSize.width)
        }
        
        view_4.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(view_3.snp.trailing)
            make.width.equalTo(screenSize.width)
        }
        
        view_5.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(view_4.snp.trailing)
            make.width.equalTo(screenSize.width)
        }
    }
    
    func initView() {
        

    }
    
    func configureView() {
        
    }

}


