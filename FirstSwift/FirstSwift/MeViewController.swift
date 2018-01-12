//
//  MeViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/9.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var mTableView : UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "我的"
    
    
    
    
    }
    
    // MARK: - mTableView初始化
    func setUpTableView() -> Void {
        
        self.mTableView = UITableView.init(frame: self.view.bounds);
        self.mTableView?.delegate = self
        self.mTableView?.dataSource = self
        self.mTableView?.backgroundColor = UIColor.clear
        self.view.addSubview(self.mTableView!)
        self.mTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.mTableView?.showsVerticalScrollIndicator = false
        self.mTableView?.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            self.mTableView?.estimatedRowHeight = 0.0
            self.mTableView?.estimatedSectionFooterHeight = 0.0
            self.mTableView?.estimatedSectionHeaderHeight = 0.0
        }
    }
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MeInfoTableViewCell.cellWithTableView(tableView: self.mTableView!, indexPath: indexPath)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


class MeInfoTableViewCell: UITableViewCell {
    
    //MARK: - 重写父类方法
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpSubViews()
    }
    
    class func cellIdentifier() -> String {
        
        let cellId = "MeInfoTableViewCell"
        
        return cellId
    }
    
    class func cellWithTableView(tableView : UITableView, indexPath : IndexPath) -> MeInfoTableViewCell {
        
        tableView.register(self, forCellReuseIdentifier: self.cellIdentifier())
        
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier(), for: indexPath)  as? MeInfoTableViewCell
        
        if cell == nil {
            
            cell = MeInfoTableViewCell.init(style:  UITableViewCellStyle.default, reuseIdentifier: self.cellIdentifier())
        }
        
        return cell!
    }
    
    //MARK: - 布局子视图
    func setUpSubViews() -> Void {
        
        
        
        
    }
}


