
//
//  PhotoChooseCollectionViewCell.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/11.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import Foundation
import UIKit


class PhotoChooseCollectionViewCell: UICollectionViewCell {
    
    var photoImageView : UIImageView?
    var selectedButton : UIButton?
    var block : (UIImage, Bool, UIButton) -> () = {image,selected,button in }
    
    class func cellIdentifier() -> String {
        
        let cellId = "PhotoChooseCollectionViewCell"
        
        return cellId
    }
    
    class func cellWithCollectionView(collectionView : UICollectionView, indexPath : IndexPath) -> PhotoChooseCollectionViewCell {
        
        collectionView.register(self, forCellWithReuseIdentifier: self.cellIdentifier())
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier(), for: indexPath)  as? PhotoChooseCollectionViewCell
        
        if cell == nil {
            
            cell = PhotoChooseCollectionViewCell.init()
        }
        
        cell?.setUpSubViews()
        
        return cell!
    }
    
    //MARK: - 布局子视图
    func setUpSubViews() -> Void {
        self.photoImageView = UIImageView.init()
        self.photoImageView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.photoImageView!)
        self.addConstraints([
            NSLayoutConstraint.init(item : self.photoImageView!, attribute : NSLayoutAttribute.top, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.top, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : self.photoImageView!, attribute : NSLayoutAttribute.left, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.left, multiplier :1, constant : 0),
            NSLayoutConstraint(item : self.photoImageView!, attribute : NSLayoutAttribute.centerY, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.centerY, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : self.photoImageView!, attribute :  NSLayoutAttribute.width, relatedBy : NSLayoutRelation.equal,  toItem : self.photoImageView!, attribute : NSLayoutAttribute.height, multiplier : 1, constant : 0)
            ])
        
        
        self.selectedButton = UIButton.init(type: UIButtonType.custom)
        self.selectedButton?.setBackgroundImage(UIImage.init(named: "selectPhotoImage"), for: UIControlState.normal)
        self.selectedButton?.setBackgroundImage(self.imageWithColor(color: UIColor.blue), for: UIControlState.selected)
        self.selectedButton?.setTitle("1", for: UIControlState.selected)
        self.selectedButton?.setTitleColor(UIColor.white, for: UIControlState.selected)
        self.selectedButton?.layer.cornerRadius = 12.5
        self.selectedButton?.layer.masksToBounds = true
        self.selectedButton?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.selectedButton!)
        self.addConstraints([
            NSLayoutConstraint.init(item : self.selectedButton!, attribute : NSLayoutAttribute.right, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.right, multiplier : 1, constant : 0),
            NSLayoutConstraint(item : self.selectedButton!, attribute : NSLayoutAttribute.top, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.top, multiplier :1, constant : 0),
            NSLayoutConstraint(item : self.selectedButton!, attribute : NSLayoutAttribute.width, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.width, multiplier : 0, constant : 25),
            NSLayoutConstraint(item : self.selectedButton!, attribute : NSLayoutAttribute.height, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.width, multiplier : 0, constant : 25),
            ])
        
        self.selectedButton?.addAction {
            
            self.selectedButton?.isSelected = !(self.selectedButton?.isSelected)!
            
            self.block((self.photoImageView?.image)!, (self.selectedButton?.isSelected)!, self.selectedButton!)
        }
    }
    // MARK: 图片生成
    func imageWithColor(color : UIColor) -> UIImage {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
}


