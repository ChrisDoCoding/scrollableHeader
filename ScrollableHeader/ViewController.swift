//
//  ViewController.swift
//  ScrollableHeader
//
//  Created by Chris Chen on 2020/5/9.
//  Copyright © 2020 Dev4App. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let contentView = ContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addSubviewConstraints()
        initView()
    }

    func addSubviews() {
        contentView.headerView.delegate = self
        contentView.scrollView.delegate = self
        view.addSubview(contentView)
    }
    
    func addSubviewConstraints() {
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    func initView() {
        
        contentView.backgroundColor = .white
    }


}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentView.headerView.updateIndicator(offsetX: scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let screenSize = UIScreen.main.bounds.size
        let offsetX = scrollView.contentOffset.x
        let pageNumber = round(offsetX / screenSize.width)
        let index = IndexPath(item: Int(pageNumber), section: 0)
        contentView.headerView.collectionView(contentView.headerView.collectionView, didSelectItemAt: index)
    }
    
}


extension ViewController: HeaderViewDelegate {
    
    func didSelectIndex(index: Int) {
        let screenSize = UIScreen.main.bounds.size
        let point = CGPoint(x: CGFloat(index) * screenSize.width, y: 0)
        contentView.scrollView.setContentOffset(point, animated: true)
    }
}
