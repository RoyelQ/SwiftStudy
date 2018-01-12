//
//  TabBarViewController.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/8.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

//MARK: - TabBarControllerDelegate
@objc protocol TabBarControllerDelegate : NSObjectProtocol {
    
    func shouldSelectViewController(tabBarController : TabBarViewController, index : NSInteger) ->  Bool
    
    func didSelectViewController(tabBarController : TabBarViewController, index : NSInteger) ->  Void
}

class TabBarViewController: UIViewController, TabBarDelegate {
    
//MARK: - 属性设置
    var tabBar : TabBar?
    var contentView : UIView?
    var delegate : TabBarControllerDelegate?
    
    var viewControllers : NSArray?
    var selectedViewController : UIViewController?
    var selectedIndex = 0
 
//MARK: - Life Cycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commonInitialization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.setSelectedIndex(selectedIndex: 0)
        
        self.setTabBarHidden(hidden: false)
    }
    //初始化
    func commonInitialization() -> Void {
        self.selectedIndex = 0
        if self.tabBar == nil {
            self.tabBar = TabBar.init()
            self.tabBar?.delegate = self
            self.contentView = UIView.init()
            self.view.addSubview(self.tabBar!)
            self.view.addSubview(self.contentView!)
        }
        //适配屏幕
        self.contentView?.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(
            UInt8(UIViewAutoresizing.flexibleHeight.rawValue) |
            UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
        self.tabBar?.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(
            UInt8(UIViewAutoresizing.flexibleWidth.rawValue) |
            UInt8(UIViewAutoresizing.flexibleTopMargin.rawValue) | UInt8(UIViewAutoresizing.flexibleLeftMargin.rawValue) |
            UInt8(UIViewAutoresizing.flexibleBottomMargin.rawValue) |
            UInt8(UIViewAutoresizing.flexibleRightMargin.rawValue)))
    }
    
    
    //MARK: - 状态栏切换
    private var _preferStatuBarUpdateAnimation = UIStatusBarAnimation.none
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        get {
            return self._preferStatuBarUpdateAnimation
        }
        set {
            self._preferStatuBarUpdateAnimation = newValue
        }
    }
    private var _preferredStatusBarStyle = UIStatusBarStyle.default
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return self._preferredStatusBarStyle
        }
        set {
            self._preferredStatusBarStyle = newValue
        }
    }
    //MARK: - 支持横屏
    private var _orientations = UIInterfaceOrientationMask.all
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        get {
            return self._orientations
        }
        set {
            self._orientations = newValue
        }
    }
    private var _autorotate = true
    override var shouldAutorotate: Bool {
        get {
            return self._autorotate
        }
        set {
            self._autorotate = newValue
        }
    }

    //MARK: - 底部导航隐藏
    func setTabBarHidden(hidden : Bool, animated : Bool) ->  Void {
        let block:() -> Void = {
            var tabBarHeight = self.tabBar?.frame.height
            if tabBarHeight == 0.0 {
                tabBarHeight = CGFloat(Tabbar_height)
            }
            let viewSize = self.view.bounds.size
            var tabBarStartingY = viewSize.height
            if !hidden {
                tabBarStartingY = viewSize.height - tabBarHeight!
            }
            self.tabBar?.isHidden = hidden
            self.tabBar?.frame = CGRect.init(x: 0, y: tabBarStartingY, width: viewSize.width, height: tabBarHeight!)
            self.contentView?.frame = CGRect.init(x: 0, y: 0, width: viewSize.width, height: (hidden ?  viewSize.height : viewSize.height - tabBarHeight!))
        }
 
        let completion : () -> Void = {
            if hidden {
                self.setTabBarHidden(hidden: true)
            }
        }
        if animated {
            UIView.animate(withDuration: 0.24, animations: completion)
        }else {
            block()
        }
    }
    
    func setTabBarHidden(hidden : Bool) -> Void {
        self.setTabBarHidden(hidden: hidden, animated: false)
    }
    
    //MARK: - 控制器初始化
    func setViewControllers(viewControllers : NSArray) ->  Void {
        if self.tabBar == nil {
            self.commonInitialization()
        }
        if (self.viewControllers != nil) && self.viewControllers?.count != 0 {
            for viewController in self.viewControllers! {
                (viewController as! UIViewController).willMove(toParentViewController: nil)
                (viewController as! UIViewController).view.removeFromSuperview()
                (viewController as! UIViewController).removeFromParentViewController()
            }
        }
 
        let tabBarItems = NSMutableArray.init()
        self.viewControllers = viewControllers.copy() as? NSArray
        for viewController in self.viewControllers! {
            let tabBarItem =  TabBarItem.init()
            tabBarItems.add(tabBarItem)
            (viewController as! UIViewController).pro_setTabBarController(tabBarController: self)
        }
        self.tabBar?.setItems(items: tabBarItems)
        self.tabBar?.setSelectedItem(selectedItem: tabBarItems.object(at: self.selectedIndex) as! TabBarItem)

    }
 
    func selectedViewController(_: Void) -> UIViewController {
        return self.viewControllers?.object(at: self.selectedIndex) as! UIViewController
    }
    
    func setSelectedIndex(selectedIndex : NSInteger) -> Void {
        if selectedIndex >= (self.viewControllers?.count)! {
            return
        }
        //前一个选中控制器移除
        if (self.selectedViewController != nil) {
            self.selectedViewController?.willMove(toParentViewController: nil)
            self.selectedViewController?.view.removeFromSuperview()
            self.selectedViewController?.removeFromParentViewController()
        }
        self.selectedIndex = selectedIndex
        //Item标签选中
        self.tabBar?.setSelectedItem(selectedItem: self.tabBar?.items?.object(at: self.selectedIndex) as! TabBarItem)
        //新选中控制器显示
        self.selectedViewController = self.viewControllers?.object(at: self.selectedIndex) as? UIViewController
        self.selectedViewController?.view.frame = (self.contentView?.bounds)!
        self.contentView?.addSubview((self.selectedViewController?.view)!)
        self.selectedViewController?.didMove(toParentViewController: self)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    //MARK: - TabBarDelegate
    @objc func shouldSelectItemAtIndex(tabBar : TabBar, index : NSInteger) ->  Bool {
        if (self.delegate != nil) && (self.delegate?.responds(to: #selector(TabBarControllerDelegate.shouldSelectViewController(tabBarController:index:))))! {
            if (!(self.delegate?.shouldSelectViewController(tabBarController: self, index: index))!) {
                return false
            }
        }
        if self.selectedViewController == self.viewControllers?.object(at: index) as? UIViewController  {
            if (self.selectedViewController?.isKind(of: UINavigationController.classForCoder()))! {
                let nav = self.selectedViewController as? UINavigationController
                if nav?.viewControllers[0] != nav?.topViewController {
                    nav?.popToRootViewController(animated:  false)
                }
            }
            return false
        }
        return true
    }
    
    @objc func didSelectItemAtIndex(tabBar : TabBar, index : NSInteger) ->  Void {
        if index < 0 || index >= (self.viewControllers?.count)! {
            return;
        }
        self.setSelectedIndex(selectedIndex: index)
        
        if (self.delegate != nil) && (self.delegate?.responds(to: #selector(TabBarControllerDelegate.didSelectViewController(tabBarController:index:))))! {

            self.delegate?.didSelectViewController(tabBarController: self, index: index)
        }
    }
}

extension UIViewController {
    private struct TabBarAssociateKeys{
        
        static var key = "Tab_Bar_Associate_Key"
    }
    
    func pro_setTabBarController(tabBarController : TabBarViewController) -> Void {

        objc_setAssociatedObject(self, &TabBarAssociateKeys.key, tabBarController, .OBJC_ASSOCIATION_ASSIGN);
    }
    //获取当前viewController的tabBarController及选中的Item标签
    func pro_tabBarController() -> TabBarViewController {
        //设置关联
        var tabBarController = objc_getAssociatedObject(self, &TabBarAssociateKeys.key)
        
        if tabBarController == nil &&  self.parent != nil {
            
            tabBarController = self.parent?.pro_tabBarController()
        }
        
        return tabBarController as! TabBarViewController
    }
    
    
    func pro_tabBarItem() -> TabBarItem {
        let tabBarController = self.pro_tabBarController()
        let index = tabBarController.selectedIndex
        return (tabBarController.tabBar?.items![index]) as! TabBarItem
    }
    
    
    func pro_setItem(tabBarItem : TabBarItem) -> Void {
        let tabBarController = self.pro_tabBarController()
        let tabBar = tabBarController.tabBar
        let index = tabBarController.selectedIndex
        let tabBarItems = tabBar?.items?.mutableCopy() as! NSMutableArray
        tabBarItems.replaceObject(at: index, with: tabBarItem)
        tabBar?.setItems(items: tabBarItems.copy() as! NSArray)
    }
}

