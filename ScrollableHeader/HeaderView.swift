//
//  HeaderView.swift
//  ScrollableHeader
//
//  Created by Chris Chen on 2020/5/9.
//  Copyright © 2020 Dev4App. All rights reserved.
//

import UIKit

let DefaultFont = UIFont.boldSystemFont(ofSize: 16)

protocol HeaderViewDelegate {
    func didSelectIndex(index: Int)
}

class HeaderView: UIView {
    
    var delegate: HeaderViewDelegate?
    
    var contentSize = CGSize.zero
    var indicatorWidth: CGFloat = 0
    
    var titleArray = [String]()
    
    let scrollView = UIScrollView()
    let scrollView_back = UIScrollView()
    let indicator = UIView()
    
    lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: self.collectionLayout)
        collectionView.setCollectionViewLayout(self.collectionLayout, animated: true)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HeaderItemCell.self, forCellWithReuseIdentifier: "HeaderCell")
        return collectionView
    }()

    lazy var collectionView_back: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: self.collectionLayout)
        collectionView.setCollectionViewLayout(self.collectionLayout, animated: true)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HeaderItemCell.self, forCellWithReuseIdentifier: "HeaderCell")
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        initView()
        addSubviews()
        addSubviewConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView_back.showsVerticalScrollIndicator = false
        scrollView_back.showsHorizontalScrollIndicator = false
    
        indicator.layer.cornerRadius = 1.5
        indicator.layer.masksToBounds = true
        indicator.backgroundColor = .systemBlue
        
        let cellWidth = contentSize.width / CGFloat(titleArray.count)
        let padding = (cellWidth - indicatorWidth) / 2.0;
        let shapeLayer = CAShapeLayer()
        let frame = CGRect(x: padding, y: 0, width: indicatorWidth, height: 40)
        let path = UIBezierPath(roundedRect: frame, cornerRadius: 10)
        shapeLayer.path = path.cgPath
        scrollView.layer.mask = shapeLayer
        
        scrollView_back.addSubview(collectionView_back)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(indicator)
        addSubview(scrollView_back)
        addSubview(scrollView)
    }
    
    func addSubviewConstraints() {
        
        scrollView_back.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
                
        collectionView_back.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.leading.equalTo(scrollView_back.snp.leading)
            make.width.equalTo(contentSize.width)
            make.height.equalTo(35)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.width.equalTo(contentSize.width)
            make.height.equalTo(35)
        }
        
        let cellWidth = contentSize.width / CGFloat(titleArray.count)
        let padding = (cellWidth - indicatorWidth) / 2.0;
        indicator.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.bottom).offset(-1)
            make.leading.equalTo(collectionView.snp.leading).offset(padding)
            make.height.equalTo(3)
            make.width.equalTo(indicatorWidth)
        }
    }
    
    func initView() {
        titleArray = ["AAAAAA", "BBBBBBB", "CCC", "DDDDDDDD", "FFFFF"]
        initContentSize()
        scrollView.contentSize = contentSize
    }
    
    func configureView() {
        
    }

    func initContentSize() {
        let screenSize = UIScreen.main.bounds.size
        var maxSize = CGSize.zero
        var initContentSize = CGSize(width: screenSize.width, height: 50)
        
        for text in titleArray {
            let textSize = text.sizeInFont(DefaultFont)
            if textSize.width > maxSize.width {
                maxSize = textSize
                indicatorWidth = textSize.width + 6.0
            }
        }
        
        let width = (maxSize.width + 20.0) * CGFloat(titleArray.count)
        if width > screenSize.width {
            initContentSize = CGSize(width: (maxSize.width + 20.0) * CGFloat(titleArray.count), height: 35)
        }
        
        contentSize = initContentSize
    }
    
    func updateIndicator(offsetX x: CGFloat) {
        let screenSize = UIScreen.main.bounds.size
        let indicatorOffsetX = (x * contentSize.width) / (CGFloat(titleArray.count) * screenSize.width)
        let cellWidth = contentSize.width / CGFloat(titleArray.count)
        let padding = (cellWidth - indicatorWidth) / 2.0;
        
        indicator.snp.updateConstraints { (make) in
            make.leading.equalTo(collectionView.snp.leading).offset(indicatorOffsetX + padding)
        }
        
        let shapeLayer = CAShapeLayer()
        let frame = CGRect(x: indicatorOffsetX + padding, y: 0, width: indicatorWidth, height: 40)
        let path = UIBezierPath(roundedRect: frame, cornerRadius: 10)
        shapeLayer.path = path.cgPath
        scrollView.layer.mask = shapeLayer
    }
}

extension HeaderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView_back.setContentOffset(scrollView.contentOffset, animated: false)
    }
}

extension HeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderItemCell {
            
            cell.label.text = titleArray[indexPath.item]
            if collectionView == self.collectionView {
                cell.backgroundColor = .black
                cell.label.textColor = .white
            } else {
                cell.backgroundColor = .white
                cell.label.textColor = .black
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = contentSize.width / CGFloat(titleArray.count)
        
        let frontX = cellWidth * CGFloat(indexPath.item)
        let backX = frontX + cellWidth
        
        if backX < screenSize.width - cellWidth {
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        } else if frontX > contentSize.width - screenSize.width + (cellWidth * 1.5) {
            scrollView.setContentOffset(CGPoint(x: contentSize.width - screenSize.width, y: 0), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x: frontX - (cellWidth * 1.5), y: 0), animated: true)
        }
        
        delegate?.didSelectIndex(index: indexPath.item)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


extension HeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentSize.width / CGFloat(titleArray.count), height: contentSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension String {
    
    func sizeInFont(_ font: UIFont) -> CGSize {
        let text = self as NSString
        
        return text.size(withAttributes: [.font : font])
    }
}
