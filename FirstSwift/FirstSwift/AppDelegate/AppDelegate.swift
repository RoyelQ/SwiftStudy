//
//  AppDelegate.swift
//  FirstSwift
//
//  Created by 乔杰 on 2018/1/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    var tabBarController : TabBarViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        
        self.setViewControllers()
        addLaunchImage()

        return true
    }

    
    
    
    func addLaunchImage() -> Void {
        let launchImageView = UIImageView.init(image: UIImage.init(named: iPhoneX ? "launchImage_iphoneX" : "launchImage_normal"))
        launchImageView.frame = CGRect.init(x: 0, y: 0, width: Screen_width, height: Screen_height)
        self.window?.addSubview(launchImageView)
        UIView.animate(withDuration: 2.0, animations: {
            
            launchImageView.frame = CGRect.init(x: -Screen_width/4, y: -Screen_height/4, width: Screen_width*1.5, height: Screen_height*1.5)
            launchImageView.alpha = 0

        }) {(finished) -> Void in
            launchImageView.removeFromSuperview()
        }
    }
    
    
    func setViewControllers() -> Void {
        
        let firstNavigationController = UINavigationController.init(rootViewController: HomeViewController())
        let secondNavigationController = UINavigationController.init(rootViewController: PromotViewController())
        let thirdNavigationController = UINavigationController.init(rootViewController: MeViewController())
        self.tabBarController = TabBarViewController()
        self.tabBarController?.setViewControllers(viewControllers: NSArray.init(objects: firstNavigationController, secondNavigationController, thirdNavigationController))
        self.window?.rootViewController = self.tabBarController;
        
        self.tabBarController?.tabBar?.setTabBarHeight(tabBarHeight: CGFloat(Tabbar_height))
        self .customizeTabBarForController(tabBarController:  self.tabBarController!)        
    }
    
    func customizeTabBarForController(tabBarController : TabBarViewController) -> Void {
        
        let tabBarItemImages = ["tabBar_1", "tabBar_2", "tabBar_3"]
        let tabBarItemTitles = ["首页", "推广", "我的"]
        var index = 0
        var item : TabBarItem?
        for tabBarItem in (tabBarController.tabBar?.items)! {
            
            item = tabBarItem as? TabBarItem
            if index == 1 {
                let badgeTextAttributes = [
                    NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),
                    NSAttributedStringKey.foregroundColor : UIColor.yellow,
                    NSAttributedStringKey.backgroundColor : UIColor.brown]
                item?.setBadge(badgeValue: "12", badgeBackgroundColor: UIColor.brown, badgeTextAttributes: badgeTextAttributes as NSDictionary)
                item?.setBadgeAppear(appear: true)
            }
            
            let selectedTitleAttributes = [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12),
                NSAttributedStringKey.foregroundColor : Main_Color]
            let unselectedTitleAttributes = [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12),
                NSAttributedStringKey.foregroundColor : UIColor.lightGray]
            item?.setItemContent(title: tabBarItemTitles[index] as NSString, selectedImageName: (tabBarItemImages[index] as NSString).appending("_hilight") as NSString, unSelctedImageName: (tabBarItemImages[index] as NSString).appending("_normal") as NSString, selectedTitleAttributes: selectedTitleAttributes as NSDictionary, unselectedTitleAttributes: unselectedTitleAttributes as NSDictionary)
            index += 1
        }
    }
    
    
    
 
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
 
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}

