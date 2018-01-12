//
//  AssetsTableViewCell.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/11.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import Foundation
import UIKit

class AssetsTableViewCell: UITableViewCell {
    
    var assetsImageView : UIImageView?
    var asstesTitleLabel : UILabel?
    var assetsCountLabel : UILabel?
    
    //MARK: - 重写父类方法
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpSubViews()
        
        self.addLineView()
    }
    
    class func cellIdentifier() -> String {
        
        let cellId = "AssetsTableViewCell"
        
        return cellId
    }
    
    
    class func cellWithTableView(tableView : UITableView, indexPath : IndexPath) -> AssetsTableViewCell {
        
        tableView.register(self, forCellReuseIdentifier: self.cellIdentifier())
        
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier(), for: indexPath)  as? AssetsTableViewCell
        
        if cell == nil {
            
            cell = AssetsTableViewCell.init(style:  UITableViewCellStyle.default, reuseIdentifier: self.cellIdentifier())
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
    }
    
    //MARK: - 布局子视图
    func setUpSubViews() -> Void {
        
        //相册第一张照片作为相册图片
        self.assetsImageView = UIImageView.init()
        self.assetsImageView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.assetsImageView!)
        self.addConstraints([
            NSLayoutConstraint.init(item : self.assetsImageView!, attribute : NSLayoutAttribute.top, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.top, multiplier : 1, constant : 12.5),
            NSLayoutConstraint(item : self.assetsImageView!, attribute : NSLayoutAttribute.left, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.left, multiplier :1, constant : 10),
            NSLayoutConstraint(item : self.assetsImageView!, attribute : NSLayoutAttribute.centerY, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.centerY, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : self.assetsImageView!, attribute :  NSLayoutAttribute.width, relatedBy : NSLayoutRelation.equal,  toItem : self.assetsImageView!, attribute : NSLayoutAttribute.height, multiplier : 1, constant : 0)
            ])
        
        //相册title
        self.asstesTitleLabel = UILabel.init()
        self.asstesTitleLabel?.font = Font(size: 17)
        self.asstesTitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.asstesTitleLabel!)
        self.addConstraints([
            NSLayoutConstraint.init(item : self.asstesTitleLabel!, attribute : NSLayoutAttribute.bottom, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.centerY, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : self.asstesTitleLabel!, attribute :  NSLayoutAttribute.left, relatedBy : NSLayoutRelation.equal,  toItem : self.assetsImageView!, attribute : NSLayoutAttribute.right, multiplier : 1, constant : 10)
            ])
        
        //相册照片数量
        self.assetsCountLabel = UILabel.init()
        self.assetsCountLabel?.font = Font(size: 15)
        self.assetsCountLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.assetsCountLabel!)
        self.addConstraints([
            NSLayoutConstraint.init(item : self.assetsCountLabel!, attribute : NSLayoutAttribute.top, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.centerY, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : self.assetsCountLabel!, attribute :  NSLayoutAttribute.left, relatedBy : NSLayoutRelation.equal,  toItem : self.assetsImageView!, attribute : NSLayoutAttribute.right, multiplier : 1, constant : 10)
            ])
        
        let moreImageView = UIImageView.init(image: UIImage.init(named: "app_more"))
        moreImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(moreImageView)
        self.addConstraints([
            NSLayoutConstraint.init(item : moreImageView, attribute : NSLayoutAttribute.centerY, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.centerY, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : moreImageView, attribute :  NSLayoutAttribute.right, relatedBy : NSLayoutRelation.equal,  toItem : self, attribute : NSLayoutAttribute.right, multiplier : 1, constant : -10),
            NSLayoutConstraint(item : moreImageView, attribute :  NSLayoutAttribute.width, relatedBy : NSLayoutRelation.equal,  toItem : self, attribute : NSLayoutAttribute.width, multiplier : 0, constant : 8),
            NSLayoutConstraint(item : moreImageView, attribute :  NSLayoutAttribute.height, relatedBy : NSLayoutRelation.equal,  toItem : self, attribute : NSLayoutAttribute.width, multiplier : 0, constant : 16)
            ])
    }
    
    //分割线
    func addLineView() -> Void {
        let lineView = UIView.init()
        lineView.backgroundColor = Separata_Line_Color
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        self.addConstraints([
            NSLayoutConstraint.init(item : lineView, attribute : NSLayoutAttribute.left, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.left, multiplier : 1, constant : 10),
            NSLayoutConstraint(item : lineView, attribute :  NSLayoutAttribute.right, relatedBy : NSLayoutRelation.equal,  toItem : self, attribute : NSLayoutAttribute.right, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : lineView, attribute :  NSLayoutAttribute.bottom, relatedBy : NSLayoutRelation.equal,  toItem : self, attribute : NSLayoutAttribute.bottom, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : lineView, attribute :  NSLayoutAttribute.height, relatedBy : NSLayoutRelation.equal,  toItem : self, attribute : NSLayoutAttribute.width, multiplier : 0, constant : 0.5)
            ])
    }
    
}



