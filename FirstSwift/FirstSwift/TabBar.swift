//
//  TabBar.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/8.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

@objc protocol TabBarDelegate : NSObjectProtocol {
 
    @objc func shouldSelectItemAtIndex(tabBar : TabBar, index : NSInteger) ->  Bool
    @objc func didSelectItemAtIndex(tabBar : TabBar, index : NSInteger) ->  Void
}

class TabBar: UIView {
    
    //MARK : - Property
    var items : NSArray?
    var delegate : TabBarDelegate?
    var selectedItem : TabBarItem?
    var tabBarHeight: CGFloat?
    var _isHidden = false
    override var isHidden: Bool {
        get {
            return _isHidden
        }
        set {
            _isHidden = newValue
        }
    }
    
    
    //重写init相关方法
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    //MARK: - 布局Item
    override func layoutSubviews() {
    
        var index = 0
        for item in self.items! {
            (item as! TabBarItem).frame = CGRect.init(x: CGFloat(index) * self.frame.width/CGFloat((self.items?.count)!), y: 0, width: self.frame.width/CGFloat((self.items?.count)!), height: self.tabBarHeight!)
            (item as! TabBarItem).setNeedsDisplay()
            index += 1
        }
    }
    
    func setItems(items : NSArray) -> Void {
        if self.items != nil {
            for item in self.items! {
                (item as! TabBarItem).removeFromSuperview()
            }
        }
        self.items = items.copy() as? NSArray
        for item in self.items! {
            (item as! TabBarItem).addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tabBarItemClick(tap:))))
            self.addSubview((item as! TabBarItem))
        
        }
    }
    
    func setSelectedItem(selectedItem : TabBarItem) -> Void {
        
        if self.selectedItem == selectedItem {
            return;
        }
        self.selectedItem?.setSelectedStatu(statu: false)
        
        self.selectedItem = selectedItem;
        
        self.selectedItem?.setSelectedStatu(statu: true)
    }
 
    
    func setTabBarHeight(tabBarHeight : CGFloat) -> Void {

        self.tabBarHeight = tabBarHeight
        self.frame = CGRect.init(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: tabBarHeight)
        //刷新tabBarCOntroller页面
        (self.delegate as! TabBarViewController).setTabBarHidden(hidden: false)
    }
    
    @objc func tabBarItemClick(tap : UITapGestureRecognizer) -> Void {

        let selectedItem = (tap.view as! TabBarItem)
        let index = self.items?.index(of: selectedItem)
        if ((self.delegate != nil) && (self.delegate?.responds(to: #selector(TabBarDelegate.shouldSelectItemAtIndex(tabBar:index:))))!) {
            let statu = self.delegate?.shouldSelectItemAtIndex(tabBar: self, index: index!)
            if  !statu! {
                return
            }
        }
        self.setSelectedItem(selectedItem: selectedItem)
        if ((self.delegate != nil) && (self.delegate?.responds(to: #selector(TabBarDelegate.didSelectItemAtIndex(tabBar:index:))))!) {
            self.delegate?.didSelectItemAtIndex(tabBar: self, index: index!)
        }
    }
}


