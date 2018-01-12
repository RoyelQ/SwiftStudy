//
//  PhotoChooseView.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/11.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

class PhotoChooseView: UIView {
    
    private var topImageScrollView : UIView?
    private var mScrollView : UIScrollView?
    private var preViewLabel : UILabel?
    private var bootomInfoView : UIView?
   
    var finishButton : UIButton?
    var selectedImageArr : NSArray?
    var appearImage = false
    
    //MARK: - 重写父类方法
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        self.selectedImageArr = NSArray.init()
        self.backgroundColor = UIColor.clear
        
        self.setUpBottomView()
    }
    init() {
        super.init(frame: CGRect.zero)
    }
    
    //MARK: - 布局子视图
    func setUpBottomView() -> Void {
        self.bootomInfoView = UIView.init(frame: CGRect.init(x: 0, y: self.frame.height - 50, width: self.frame.width, height: 50))
        self.bootomInfoView?.alpha = 0.6
        self.bootomInfoView?.backgroundColor = UIColor.black
        self.addSubview(self.bootomInfoView!)
        
        self.preViewLabel = UILabel.init()
        self.preViewLabel?.textColor = UIColor.white
        self.preViewLabel?.font = Font(size: 15)
        self.preViewLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.bootomInfoView?.addSubview(self.preViewLabel!)
        self.preViewLabel?.text = "预览"
        self.addConstraints([
            NSLayoutConstraint.init(item : self.preViewLabel!, attribute : NSLayoutAttribute.left, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.left, multiplier : 1, constant : 15),
            NSLayoutConstraint(item : self.preViewLabel!, attribute : NSLayoutAttribute.centerY, relatedBy : NSLayoutRelation.equal, toItem : self.bootomInfoView, attribute : NSLayoutAttribute.centerY, multiplier : 1, constant : 0),
            ])
        
        
        self.finishButton = UIButton.init(type: UIButtonType.custom)
        self.finishButton?.backgroundColor = UIColor.green
        self.finishButton?.setTitle("完成", for: UIControlState.normal)
        self.finishButton?.titleLabel?.font = Font(size: 14)
        self.finishButton?.layer.cornerRadius = 3
        self.finishButton?.layer.masksToBounds = true
        self.finishButton?.translatesAutoresizingMaskIntoConstraints = false
        self.bootomInfoView!.addSubview(self.finishButton!)
        self.addConstraints([
            NSLayoutConstraint.init(item : self.finishButton!, attribute : NSLayoutAttribute.right, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.right, multiplier : 1, constant : -10),
            NSLayoutConstraint(item : self.finishButton!, attribute : NSLayoutAttribute.centerY, relatedBy : NSLayoutRelation.equal, toItem : self.bootomInfoView, attribute : NSLayoutAttribute.centerY, multiplier :1, constant : 0),
            NSLayoutConstraint(item : self.finishButton!, attribute : NSLayoutAttribute.width, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.width, multiplier : 0, constant : 50),
            NSLayoutConstraint(item : self.finishButton!, attribute : NSLayoutAttribute.height, relatedBy : NSLayoutRelation.equal, toItem : self, attribute : NSLayoutAttribute.width, multiplier : 0, constant : 28),
            ])
    }
    
    func setTopImageScrollView() -> Void {
        if self.topImageScrollView == nil {
            self.topImageScrollView = UIView.init(frame: CGRect.init(x: 0, y: self.frame.height - 50 - 65, width: self.frame.width, height: 65))
            self.topImageScrollView?.alpha = 0.4
            self.topImageScrollView?.backgroundColor = UIColor.black
            self.addSubview(self.topImageScrollView!)
            
            self.mScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: 65))
            self.mScrollView?.backgroundColor = UIColor.white
            self.topImageScrollView!.addSubview(self.mScrollView!)
        }else {
            self.topImageScrollView?.isHidden = false
        }
    }
    
    
    func setUpSelectedImageArr(imageArr : NSArray) -> Void {
        if imageArr.count != 0 {
            self.selectedImageArr = imageArr
            self.preViewLabel?.text = "预览" + String.init(format: "(%d)", imageArr.count)
            self.bootomInfoView?.alpha = 0.8
        }else {
            self.preViewLabel?.text = "预览"
            self.selectedImageArr = NSArray.init()
            self.bootomInfoView?.alpha = 0.6
        }
        let appear = self.appearImage && self.selectedImageArr?.count != 0
        let appearFloat = CGFloat(appear ? 1.0 : 0.0)
        self.frame = CGRect.init(x: self.frame.minX, y: UIScreen.main.bounds.height - 50 - appearFloat * 65, width: self.frame.width, height: appearFloat * 65 + 50)
        self.topImageScrollView?.isHidden = !appear
    }
}


