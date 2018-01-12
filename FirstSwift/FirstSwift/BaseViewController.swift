//
//  BaseViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
 
    var ifSupportLeftNavTransition = true
    
    
    //MARK : - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Main_Background_Color
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        handleNavigationTransition()
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
 
    
    //MARK: - 重写侧滑返回
    func handleNavigationTransition()
    {
        if self.ifSupportLeftNavTransition {
            let target = self.navigationController?.interactivePopGestureRecognizer!.delegate
            let pan = UIPanGestureRecognizer(target:target, action: Selector(("handleNavigationTransition:")))
            pan.delegate = self as? UIGestureRecognizerDelegate
            self.view.addGestureRecognizer(pan)
            //系统策划返回功能 只有从屏幕左侧边缘滑动才会退出（非屏幕任意位置开始策划返回） 所以关掉系统侧滑返回 true开启 false关闭
            self.navigationController?.interactivePopGestureRecognizer!.isEnabled = false
            return
        }
        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = false
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if self.childViewControllers.count == 1     //没有push的界面不会触发侧滑
        {
            return false
        }
        return true
    }
 
}

