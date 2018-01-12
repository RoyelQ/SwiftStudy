//
//  TabBarItem.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/8.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

class TabBarItem: UIView {
// MARK: - Property
    //背景图片及背景颜色
    var selectedBackgroundImageColor : UIColor?
    var unselectedBackgroundImageColor : UIColor?
    var selectedBackgroundImageName : NSString?
    var unselectedBackgroundImageName : NSString?

    //标签标题 选中状态和非选中状态
    var title : NSString?
    var selectedTitleAttributes : NSDictionary?
    var unSelectedTitleAttributes : NSDictionary?
    
    //选中图片名称和未被选中状态图片名称
    var selectedImageName : NSString?
    var unselectedImageName : NSString?

    //badge
    var badgeValue : NSString?
    var badgeTextAttributes : NSDictionary?
    var badgeBackgroundColor : UIColor?
    var badgeFourgroundColor : UIColor?
    var badgeAppear = false
    
    //偏移量 计算方式均以标签居中开始计算
    var imagePositionAdjustment : UIOffset?
    var titlePositionAdjustment : UIOffset?
    var badgePositionAdjustment : UIOffset?
    //标签选中状态
    var selectedStatu = false
    
    
// MARK: - 初始化
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.commonInitialization()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.commonInitialization()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.commonInitialization()
    }
    
    
//MARK: - 初始化标签样式
    func commonInitialization() -> Void {
        self.backgroundColor = UIColor.clear
        
        self.title = ""
        self.selectedImageName = ""
        self.unselectedImageName = ""
 
        self.badgeValue = ""
        self.badgeBackgroundColor = UIColor.white
        self.badgeFourgroundColor = UIColor.white
 
        //默认字体样式
        self.unSelectedTitleAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.lightGray,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12),
        ]
        self.selectedTitleAttributes = self.unSelectedTitleAttributes?.copy() as? NSDictionary
        self.badgeTextAttributes = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.backgroundColor : UIColor.red]
        //设置默认图片文字偏移量
        imagePositionAdjustment = UIOffsetMake(0, 0);
        titlePositionAdjustment = UIOffsetMake(0, 5);
        badgePositionAdjustment = UIOffsetMake(0, 0);

        self.selectedBackgroundImageColor = UIColor.white
        self.unselectedBackgroundImageColor = UIColor.white
        self.selectedBackgroundImageName = ""
        self.unselectedBackgroundImageName = ""
    }
    
// MARK: - Item元素设置
    func setItemContent(title : NSString, selectedImageName : NSString, unSelctedImageName : NSString, selectedTitleAttributes : NSDictionary, unselectedTitleAttributes : NSDictionary) -> Void {
        
        self.title = title
        self.selectedImageName = selectedImageName
        self.unselectedImageName = unSelctedImageName
        self.selectedTitleAttributes = selectedTitleAttributes
        self.unSelectedTitleAttributes = unselectedTitleAttributes
    }
    
    func setBackgroundImage(selelctedBackgroundImageName : NSString, unselelctedBackgroundImageName : NSString) -> Void {
        
        self.selectedBackgroundImageName = selelctedBackgroundImageName;
        self.unselectedBackgroundImageName = unselelctedBackgroundImageName
    }
    
    func setBadge(badgeValue : NSString, badgeBackgroundColor : UIColor, badgeTextAttributes : NSDictionary) -> Void {
        
        self.badgeValue = badgeValue
        self.badgeBackgroundColor = badgeBackgroundColor
        self.badgeTextAttributes = badgeTextAttributes
    }
    
    func setBadgeAppear(appear : Bool) -> Void {
       
        self.badgeAppear = appear
        self.setNeedsDisplay()
    }
    
    func setSelectedStatu(statu : Bool) -> Void {
        
        self.selectedStatu = statu
        self.setNeedsDisplay()
    }
    

// MARK: 绘制图片和标题
    override func draw(_ rect: CGRect) {
        let frameSize = self.frame.size
        var titleAttributes : NSDictionary?
        var backgroundImage : UIImage?
        var image : UIImage?
        var imageStartY : CGFloat?
        if self.selectedStatu {
            image = UIImage.init(named: self.selectedImageName! as String)
            if self.selectedBackgroundImageName?.length != 0 {
                backgroundImage = UIImage.init(named: self.selectedBackgroundImageName! as String)
            }else {
                backgroundImage = self.imageWithColor(color: self.selectedBackgroundImageColor! as UIColor)
            }
            titleAttributes = self.selectedTitleAttributes!
        }else {
            image = UIImage.init(named: self.unselectedImageName! as String)
            if self.unselectedBackgroundImageName?.length != 0 {
                backgroundImage = UIImage.init(named: self.unselectedBackgroundImageName! as String)
            }else {
                backgroundImage = self.imageWithColor(color: self.unselectedBackgroundImageColor! as UIColor)
            }
            titleAttributes = self.unSelectedTitleAttributes!
        }
        
        let context = UIGraphicsGetCurrentContext();
        context?.saveGState()
        backgroundImage?.draw(in : CGRect.init(x: 0, y: 0, width: frameSize.width, height: frameSize.height))
        

        let imageSize = image?.size
        let titleSize = self.title?.boundingRect(with: CGSize.init(width: frameSize.width, height: 20), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: titleAttributes as? [NSAttributedStringKey : Any], context: nil).size
        
        if self.title?.length == 0 {
            imageStartY = round((frameSize.height - (imageSize?.height)!)/2.0 + (imagePositionAdjustment?.vertical)!);
           
            image?.draw(in: CGRect.init(x: (frameSize.width - (imageSize?.width)!)/2.0 +  (imagePositionAdjustment?.horizontal)!, y: imageStartY!, width: (imageSize?.width)!, height: (imageSize?.height)!))
        }else {
            
            imageStartY = round((frameSize.height - (imageSize?.height)! - (titleSize?.height)!)/2.0 + (imagePositionAdjustment?.vertical)!);
            image?.draw(in: CGRect.init(x: (frameSize.width - (imageSize?.width)!)/2.0 + (imagePositionAdjustment?.horizontal)!, y: imageStartY!, width:  (imageSize?.width)!, height:  (imageSize?.height)!))

            context?.setFillColor((titleAttributes?.object(forKey: NSAttributedStringKey.foregroundColor)! as! UIColor).cgColor)

            self.title?.draw(in: CGRect.init(x:  (frameSize.width - (titleSize?.width)!)/2.0 + (titlePositionAdjustment?.horizontal)!, y: imageStartY!  + (imageSize?.height)! + (imagePositionAdjustment?.vertical)! + (titlePositionAdjustment?.vertical)! , width: (titleSize?.width)!, height: (titleSize?.height)!), withAttributes: (titleAttributes as! [NSAttributedStringKey : Any]))
        }
 
        if self.badgeAppear {
            self.drawBadgeVlaue(imageStartY: imageStartY!, imageSize: imageSize!, titleSize: titleSize!)
        }
        context?.restoreGState()

    }
    
    
    //绘制badge
    func drawBadgeVlaue(imageStartY : CGFloat, imageSize : CGSize, titleSize : CGSize) -> Void {
        
        let frameSize = self.frame.size
        var badgeTextSize = self.badgeValue?.boundingRect(with:  CGSize.init(width: frameSize.width, height: 20), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: self.badgeTextAttributes as? [NSAttributedStringKey : Any], context: nil).size
        if Double((badgeTextSize?.width)!) < Double((badgeTextSize?.height)!) {

            badgeTextSize = CGSize.init(width: (badgeTextSize?.height)! + 10.0, height: (badgeTextSize?.height)!)
            
        }else {
            var width = (badgeTextSize?.width)! + 10.0
            let badgeStartX = roundf(Float(frameSize.width/2.0 + imageSize.width/2.0*0.85 + (badgePositionAdjustment?.horizontal)!));
            if Double(width) > Double(frameSize.width) - Double(badgeStartX) - Double((badgePositionAdjustment?.horizontal)!) {
                width = frameSize.width - CGFloat(badgeStartX) - (badgePositionAdjustment?.horizontal)! > 30.0 ? 30.0 : (frameSize.width - CGFloat(badgeStartX) - (badgePositionAdjustment?.horizontal)!)
            }
            badgeTextSize = CGSize.init(width: (badgeTextSize?.width)! + 10.0, height: (badgeTextSize?.height)!)
        }
 
        
        if self.badgeValue?.length == 0 {
            badgeTextSize = CGSize.init(width: 10.0, height: 10.0)
        }else {
            if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1 {
                
                let badgeTextStyle = NSMutableParagraphStyle.init()
                badgeTextStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
                badgeTextStyle.alignment = NSTextAlignment.center
                
                let badgeTextMutableAttributes = self.badgeTextAttributes?.mutableCopy() as! NSMutableDictionary
                badgeTextMutableAttributes.setValue(badgeTextStyle, forKey: NSAttributedStringKey.paragraphStyle.rawValue)
                self.badgeTextAttributes = badgeTextMutableAttributes.copy() as? NSDictionary
            }
        }
        //起始位置
        let badgeStartX = CGFloat(roundf(Float(frameSize.width/2.0 + imageSize.width/2.0*0.85 + (badgePositionAdjustment?.horizontal)!)))
        
        let badgeStartY = (badgePositionAdjustment?.vertical)! + imageStartY;
        let radius = CGFloat((badgeTextSize?.height)!/2.0);
        // 获取CGContext，注意UIKit里用的是一个专门的函数
        let context = UIGraphicsGetCurrentContext();
        // 移动到初始点

        context?.move(to: CGPoint.init(x: badgeStartX + radius, y: badgeStartY))
        // 绘制第1条线和第1个1/4圆弧
        context?.addArc(center: CGPoint.init(x: badgeStartX + radius, y: badgeStartY + radius), radius: radius, startAngle: CGFloat(1.5 * Double.pi), endAngle: CGFloat(Double.pi), clockwise: true)
        context?.addLine(to: CGPoint.init(x: badgeStartX, y: badgeStartY + (badgeTextSize?.height)! - radius));
        // 绘制第2条线和第2个1/4圆弧
        context?.addArc(center: CGPoint.init(x: badgeStartX + radius, y: badgeStartY + (badgeTextSize?.height)!  - radius), radius: radius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(0.5 * Double.pi), clockwise: true)
        context?.addLine(to: CGPoint.init(x: badgeStartX + (badgeTextSize?.width)! - radius, y: badgeStartY + (badgeTextSize?.height)!));
        // 绘制第3条线和第3个1/4圆弧
        context?.addArc(center: CGPoint.init(x: badgeStartX + (badgeTextSize?.width)! - radius, y: badgeStartY + (badgeTextSize?.height)! - radius), radius: radius, startAngle: CGFloat(0.5 * Double.pi), endAngle: 0.0, clockwise: true)
        context?.addLine(to: CGPoint.init(x: badgeStartX + (badgeTextSize?.width)!, y: badgeStartY + radius))
        
        // 绘制第4条线和第4个1/4圆弧
        context?.addArc(center: CGPoint.init(x: badgeStartX + (badgeTextSize?.width)! - radius, y: badgeStartY + radius), radius: radius, startAngle: 0.0, endAngle: CGFloat(-0.5 * Double.pi), clockwise: true)
        context?.addLine(to: CGPoint.init(x: badgeStartX + radius, y: badgeStartY))
        // 闭合路径
        context?.closePath()
        context?.setLineWidth(1.0)
        context?.setStrokeColor((self.badgeBackgroundColor?.cgColor)!)
        context?.setFillColor((self.badgeBackgroundColor?.cgColor)!)
        context?.drawPath(using: CGPathDrawingMode.fill)
        
        if (self.badgeValue?.length != 0) {
            let badgeRect =  CGRect.init(x: badgeStartX, y: badgeStartY, width: (badgeTextSize?.width)!, height: (badgeTextSize?.height)!)
            self.badgeValue?.draw(in:  badgeRect, withAttributes: self.badgeTextAttributes as? [NSAttributedStringKey : Any])
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

