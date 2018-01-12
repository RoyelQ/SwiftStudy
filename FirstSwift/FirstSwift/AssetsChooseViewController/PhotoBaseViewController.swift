//
//  PhotoBaseViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/11.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

class PhotoBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    
    
    }
 
    //MARK: - 添加左侧返回按钮
    func addBackButton(leftButtonClickHandle : ()->Void) -> Void {
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 30)
        button.setImage(UIImage.init(named: "app_back"), for: UIControlState.normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        
        button.addAction(block: leftButtonClickHandle)
        
        let leftSpacer = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        leftSpacer.width = -10
        let barButtonItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItems = [leftSpacer, barButtonItem]
    }
    
    func backAction() -> Void {
        if self.navigationController?.childViewControllers.count == 1 {
            return
        }
        self.navigationController?.popViewController(animated: true)
    }

    
    /**
     *  压缩图片到指定文件大小
     *  @param image 目标图片
     *  @param size  目标大小（最大值）
     *  @return 返回的图片文件
     */
    func compressOriginalImage(image : UIImage, size : CGFloat) -> UIImage {
        
        var data = UIImageJPEGRepresentation(image, 1.0)! as NSData
        var dataBytes = CGFloat(data.length)/1000.0
        var maxQuality = 0.9
        var lastDataBytes = dataBytes
        while dataBytes > size && maxQuality > 0.01 {
            maxQuality -= 0.01
            data = UIImageJPEGRepresentation(image, CGFloat(maxQuality))! as NSData
            dataBytes = CGFloat(data.length)/1000.0
            if lastDataBytes == dataBytes {
                break
            }else {
                lastDataBytes = dataBytes
            }
        }
        return UIImage.init(data: data as Data)!
    }

}
